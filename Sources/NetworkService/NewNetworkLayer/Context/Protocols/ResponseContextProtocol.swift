//
//  ResponseContextProtocol.swift
//  
//
//  Created by Князьков Илья on 10.03.2022.
//

import Foundation

protocol ResponseContextProtocol {
    
    associatedtype Input
    
    func onComplete(_ onComplete: @escaping (Input) -> Void) -> Self
    func onError(_ onError: @escaping (Error) -> Void) -> Self
    func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output>
    func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> AnyResponseContex<Output>
    func removeAllSubScriptions()
    
}

open class AnyResponseContex<Input>: AnyResultDecoder<Input>, ResponseContextProtocol {
    
    @discardableResult
    open func onComplete(_ onComplete: @escaping (Input) -> Void) -> Self {
        self
    }
    
    @discardableResult
    open func onError(_ onError: @escaping (Error) -> Void) -> Self {
        self
    }
    
    open override func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output> {
        AnyResponseContex<Output>()
    }
    
    @discardableResult
    open func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> AnyResponseContex<Output> {
        AnyResponseContex<Output>()
    }
    
    open func removeAllSubScriptions() { }
    
}
