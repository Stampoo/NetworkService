//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

public protocol NetworkRoute {
    var completeURL: URL? { get }
    var baseLink: String { get }
    var path: String { get }
    var requestMethod: RequestMethod { get }
}

public extension NetworkRoute {
    
    var completeURL: URL? {
        URL(string: baseLink + path)
    }

}