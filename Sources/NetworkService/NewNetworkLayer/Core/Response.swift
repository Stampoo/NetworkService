//
//  Response.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

public struct Response {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}

extension Response {
    
    // MARK: - Public properties
    
    var code: Int {
        (response as? HTTPURLResponse)?.statusCode ?? .zero
    }
    
    var json: [String: Any] {
        guard let data = data else {
            return [String: Any]()
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return (json as? [String: Any]) ?? [String: Any]()
    }
    
    var arrayOfJson: [[String: Any] ] {
        guard let data = data else {
            return [[String: Any]]()
        }
        let arrayOfJson = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        return (arrayOfJson as? [[String: Any] ]) ?? [[String: Any]]()
    }
    
}
