//
//  ResponseContext.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

open class ResponseContext<Input> {
    
    enum StoredResult {
        case error(_ error: Error)
        case data(_ data: Input)
    }
    
    private var storedResult: StoredResult
    
    init(storedResult: StoredResult) {
        self.storedResult = storedResult
    }
    
}

// MARK: - ResponseTransformProtocol

extension ResponseContext: ResponseTransformProtocol {
    
    private enum Errors: String {
        case transformWasNotStart = "Transform not was processed, context does not contain information for transformation"
    }
    
    public func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> ResponseContext<Output> {
        guard case let .data(transformableData) = storedResult else {
            fatalError(Errors.transformWasNotStart.rawValue)
        }
        return ResponseContext<Output>(storedResult: .data(try transform(transformableData)))
    }
    
}
