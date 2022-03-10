//
//  ResponseContextProtocol.swift
//  
//
//  Created by Князьков Илья on 10.03.2022.
//

import Foundation

protocol ResponseContextProtocol {
    
    associatedtype Input
    
    func onComplete(_ onComplete: @escaping (Input) -> Void)
    func onError(_ onError: @escaping (Error) -> Void)
    func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output>
    func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> AnyResponseContex<Output>
    
}

open class AnyResponseContex<Input>: ResponseContextProtocol {
    
    open func onComplete(_ onComplete: @escaping (Input) -> Void) { }
    open func onError(_ onError: @escaping (Error) -> Void) { }
    
    open func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output> {
        AnyResponseContex<Output>()
    }
    
    @discardableResult
    func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> AnyResponseContex<Output> {
        AnyResponseContex<Output>()
    }
    
}
