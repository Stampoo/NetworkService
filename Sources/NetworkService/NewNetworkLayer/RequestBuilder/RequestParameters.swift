//
//  RequestParameters.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

struct RequestParameters: RequestParametersProtocol {
    
    let body: Data?
    let queryItems: [URLQueryItem]
    
    init(from encodingType: ParametersEncodingType) throws {
        switch encodingType {
        case .json(let parameters):
            self.body = try JSONSerialization.data(withJSONObject: parameters, options: [])
            self.queryItems = []
        case .query(let parameters):
            self.body = nil
            self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
    }
    
}
