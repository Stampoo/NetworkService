//
//  RequestMethod.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

public enum RequestMethod: String {

    case get
    case post
    case put
    case delete
    
}

extension RequestMethod: RequestMethodProtocol {
    
    var method: String {
        rawValue.uppercased()
    }
    
}
