//
//  RequestProtocol.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

public protocol RequestProtocol {
    
    func getRequest() throws -> URLRequest
    
}
