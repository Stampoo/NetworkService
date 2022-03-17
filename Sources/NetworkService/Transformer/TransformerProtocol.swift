//
//  TransformerProtocol.swift
//  
//
//  Created by Князьков Илья on 17.03.2022.
//

import Combine

public protocol TransformerProtocol {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Context<Output>
    
}
