//
//  File.swift
//  
//
//  Created by Илья Князьков on 19/11/2020.
//

import Foundation

public enum NetworkError {
    case badURL
    case badRequest
    case objectHasWeakLink
    case badResponse
    case unknownError(code: Int)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badResponse:
            return "Bad response!"
        case .badRequest:
            return "Bad request!"
        case .badURL:
            return "Bad URL!"
        case .objectHasWeakLink:
            return "Object has weak link!"
        case .unknownError(let code):
            return "UnknownError! Code: \(code)"
        }
    }

}
