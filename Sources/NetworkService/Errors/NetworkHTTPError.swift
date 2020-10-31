//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

public enum NetworkHTTPError {
    case badRequest
    case notFound
    case unknownError(_ code: Int)
}

extension NetworkHTTPError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad request!"
        case .notFound:
            return "Server not found!"
        case .unknownError(let code):
            return "Unknown error with code: \(code)!"
        }
    }
    
}
