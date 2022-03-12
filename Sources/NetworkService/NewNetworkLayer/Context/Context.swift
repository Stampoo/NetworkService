//
//  ResponseContext.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

open class Context<Input>: AnyResponseContex<Input> {
    
    // MARK: - Nested types
    
    private enum Errors: Error {
        case inputDataWasNotFound
    }
    
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
    
    public override init() { }
    
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
    
    // MARK: - AnyResponseContex
    
    @discardableResult
    public override func onComplete(_ onComplete: @escaping (Input) -> Void) -> Self {
        self.onComplete = onComplete
        guard let data = lastSendedData else {
            return self
        }
        onComplete(data)
        return self
    }
    
    @discardableResult
    public override func onError(_ onError: @escaping (Error) -> Void) -> Self {
        self.onError = onError
        guard let error = lastSendedError else {
            return self
        }
        onError(error)
        return self
    }
    
    open override func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output> {
        do {
           return try map { response in
                guard let response = response as? Response, let data = response.data else {
                    throw Errors.inputDataWasNotFound
                }
                return try JSONDecoder().decode(Output.self, from: data)
            }
        }
        catch {
            return Context<Output>().send(error)
        }
    }
    
    @discardableResult
    public override func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> Context<Output> {
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
