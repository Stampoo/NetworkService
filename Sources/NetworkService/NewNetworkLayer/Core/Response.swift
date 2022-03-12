//
//  Response.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

public struct Response {
    
    public let data: Data?
    
    let response: URLResponse?
    let error: Error?
    
}

extension Response {
    
    private enum Errors: Error {
        case dataWasNotFound
        case dataCouldNotBeDecodedAsJson
    }
    
    var code: Int {
        (response as? HTTPURLResponse)?.statusCode ?? .zero
    }
    
    public func asJson() throws -> [String: Any] {
        guard let data = data else {
            throw Errors.dataWasNotFound
        }
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        if let json = jsonObject as? [String: Any] {
            return json
        }
        throw Errors.dataCouldNotBeDecodedAsJson
    }
    
    public func asArrayJson() throws -> [[String: Any]] {
        guard let data = data else {
            throw Errors.dataWasNotFound
        }
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        if let json = jsonObject as? [[String: Any]] {
            return json
        }
        throw Errors.dataCouldNotBeDecodedAsJson
    }
    
}
