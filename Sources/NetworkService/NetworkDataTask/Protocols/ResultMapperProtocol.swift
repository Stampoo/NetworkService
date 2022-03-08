//
//  ResultMapperProtocol.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

public protocol ResultMapperProtocol {
    
    func map<Output: Codable>(on type: Output.Type) throws ->  AnyResultReceiver<Output>
    func map<Input, Output: Decodable>(_ transform: (Input) throws -> Output) rethrows ->  AnyResultReceiver<Output>
    
}

