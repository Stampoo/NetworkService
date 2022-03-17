//
//  ResultDecoder.swift
//  
//
//  Created by Князьков Илья on 12.03.2022.
//

import Foundation

protocol ResultDecoder {
    
    associatedtype Input
    
    func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output>
    
}

open class AnyResultDecoder<Input> {
    
    @discardableResult
    open func decode<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output> {
        AnyResponseContex<Output>()
    }

}
