//
//  RequestBuilder.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

public struct RequestBuilder: RequestBuilderProtocol {
    
    public var request: RequestProtocol
    
    public init(url: URL?,
                         method: RequestMethod,
                         parameters: ParametersEncodingType,
                         headers: [String: String]) throws {
        self.request = Request(
            url: url,
            method: method,
            parameters: try RequestParameters(from: parameters),
            headers: RequestHeaders(fields: headers)
        )
    }
    
}
