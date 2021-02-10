//
//  File.swift
//  
//
//  Created by fivecoil on 23.10.2020.
//

import Foundation

public struct Response {
    let data: Data?
    let error: Error?
    let response: URLResponse?
}

// MARK: - Extensions

extension Response {
    
    // MARK: - Public properties
    
    var code: Int {
        (response as? HTTPURLResponse)?.statusCode ?? .zero
    }
    
    var json: Json {
        guard let data = data else {
            return Json()
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return (json as? Json) ?? Json()
    }
    
    var arrayOfJson: [Json] {
        guard let data = data else {
            return [Json]()
        }
        let arrayOfJson = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        return (arrayOfJson as? [Json]) ?? [Json]()
    }
    
}
