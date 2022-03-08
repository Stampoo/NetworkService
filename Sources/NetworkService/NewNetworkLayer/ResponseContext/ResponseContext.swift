//
//  ResponseContext.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

open class ResponseContext<Input> {
    
    public enum StoredResult {
        case error(_ error: Error)
        case data(_ data: Input)
    }
    
    private var storedResult: StoredResult
    private var onComplete: (StoredResult) -> Void = { _ in }
    
    init(storedResult: StoredResult) {
        self.storedResult = storedResult
    }
    
    func emit(_ result: StoredResult) {
        storedResult = result
        self.onComplete(result)
    }
    
    public func onComplete(_ onComplete: @escaping (StoredResult) -> Void) {
        self.onComplete = onComplete
    }

}

// MARK: - ResponseTransformProtocol

extension ResponseContext: ResponseTransformProtocol {
    
    private enum Errors: String, Error {
        case transformWasNotStart = "Transform not was processed, context does not contain information for transformation"
    }
    
    @discardableResult
    public func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> ResponseContext<Output> {
        let context = ResponseContext<Output>(storedResult: .error(NSError()))
        onComplete { result in
            guard case let .data(data) = result else {
                context.emit(.error(Errors.transformWasNotStart))
                return
            }
            do {
                context.emit(.data(try transform(data)))
            }
            catch {
                context.emit(.error(error))
            }
        }
        return context
    }
    
}
