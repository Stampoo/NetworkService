//
//  ResponseContext.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

open class Context<Input> {
    
    // MARK: - Private properties
    
    @Atomic
    private var lastSendedData: Input?
    @Atomic
    private var lastSendedError: Error?
    @Atomic
    private var onComplete: (Input) -> Void = { _ in }
    @Atomic
    private var onError: (Error) -> Void = { _ in }
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Public properties
    
    @discardableResult
    public func send(_ newData: Input) -> Self {
        lastSendedData = newData
        performCompletion(send: newData)
        return self
    }
    
    @discardableResult
    public func send(_ error: Error) -> Self {
        lastSendedError = error
        performErrorNotification(send: error)
        return self
    }
    
    public func onComplete(_ onComplete: @escaping (Input) -> Void) {
        self.onComplete = onComplete
    }
    
    public func onError(_ onError: @escaping (Error) -> Void) {
        self.onError = onError
    }

}

// MARK: - ResponseTransformProtocol

extension Context: ResponseTransformProtocol {
    
    private enum Errors: String, Error {
        case transformWasNotStart = "Transform not was processed, context does not contain information for transformation"
    }
    
    @discardableResult
    func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> Context<Output> {
        let context = Context<Output>()
        onComplete { data in
            do {
                context.send(try transform(data))
            }
            catch {
                context.send(error)
            }
        }
        return context
    }
    
}

// MARK: - ResultMapperProtocol

extension Context: ResultMapperProtocol where Context.Input == Response {
}

// MARK: - Private methods

extension Context {
    
    func performCompletion(send newValue: Input) {
        onComplete(newValue)
        clean()
    }
    
    func performErrorNotification(send error: Error) {
        onError(error)
        clean()
    }
    
    func clean() {
        lastSendedData = nil
        lastSendedError = nil
    }
    
}
