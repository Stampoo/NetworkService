//
//  ResultMapperProtocol.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

public protocol ResultMapperProtocol {
    
    func map<Output: Decodable>(on type: Output.Type) -> ResponseContext<Output>
    
}

extension ResultMapperProtocol where Self: ResponseContext<Response> {
    
    public func map<Output: Decodable>(on type: Output.Type) -> ResponseContext<Output> {
        do {
           return try map { response in
                guard let data = response.data else {
                    throw NSError()
                }
                return try JSONDecoder().decode(Output.self, from: data)
            }
        }
        catch {
            return ResponseContext<Output>(storedResult: .error(error))
        }
    }
    
}
