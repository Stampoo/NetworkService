//
//  Request.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

struct Request {
    
    let url: URL?
    let method: RequestMethodProtocol
    let parameters: RequestParametersProtocol
    let headers: RequestHeadersProtocol
    
}

extension Request: RequestProtocol {
    
    enum Errors: Error {
        case cantBuildComponentsFromUrl
        case cantBuildUrlWithQuery
        case invalidUrl
    }
    
    func getRequest() throws -> URLRequest {
        guard let url = url else {
            throw Errors.invalidUrl
        }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw Errors.cantBuildComponentsFromUrl
        }
        components.queryItems = parameters.queryItems
        guard let buildedUrl = components.url else {
            throw Errors.cantBuildUrlWithQuery
        }
        var request = URLRequest(url: buildedUrl)
        request.httpBody = parameters.body
        request.allHTTPHeaderFields = headers.fields
        
        return request
    }
    
}
