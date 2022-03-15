//
//  ResultMapperProtocol.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

public protocol ResultMapperProtocol {
    
    func map<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output>
    
}

extension ResultMapperProtocol where Self: Context<Response> {
    
    public func map<Output: Decodable>(on type: Output.Type) -> AnyResponseContex<Output> {
        map { response in
             guard let data = response.data else {
                 throw response.error ?? NSError()
             }
             return try JSONDecoder().decode(Output.self, from: data)
         }
    }
    
}
