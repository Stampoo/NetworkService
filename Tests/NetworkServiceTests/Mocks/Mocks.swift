//
//  Mocks.swift
//  
//
//  Created by Князьков Илья on 10.03.2022.
//

import Foundation


enum TestRoute {
    
    private static let baseLink = "https://jsonplaceholder.typicode.com"
    private static let path = "/todos/1"
    static let url = URL(string: baseLink + path)

}

struct Test: Codable { }
