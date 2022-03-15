//
//  RequestBuilder.swift
//  
//
//  Created by Князьков Илья on 15.03.2022.
//

import Foundation


public struct RequestBuilder: RequestBuilderProtocol {
  
    // MARK: - Public properties
    
    public let url: URL?
    public let method: RequestMethod
    public let parameters: ParametersEncodingType
    public let headers: [String: String]
    
    // MARK: - Initialization
    
    public init(url: URL?,
                method: RequestMethod,
                parameters: ParametersEncodingType,
                headers: [String : String]) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
    // MARK: - RequestBuilderProtocol
    
    public func build() throws -> Request {
        Request(
            url: url,
            method: method,
            parameters: try RequestParameters(from: parameters),
            headers: RequestHeaders(fields: headers)
        )
    }
    
}
