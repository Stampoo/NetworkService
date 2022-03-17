//
//  ResultDecoder.swift
//  
//
//  Created by Князьков Илья on 12.03.2022.
//

import Foundation

protocol ResultDecoder {
    
    associatedtype Input
    
    @available(iOS 13, *)
    var publisher: AnyPublisher<Input, Error, Context<Input>> { get }

    func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output>
    
}

open class AnyResultDecoder<Input> {
    
    @available(iOS 13, *)
    public var publisher: AnyPublisher<Input, Error, Context<Input>> {
        fatalError("should be overridden in subclass before use!")
    }
    
    @discardableResult
    open func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output> {
        AnyResponseContex<Output>()
    }

}
