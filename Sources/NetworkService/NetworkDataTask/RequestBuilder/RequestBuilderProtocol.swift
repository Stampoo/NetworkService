//
//  RequestBuilderProtocol.swift
//  
//
//  Created by Князьков Илья on 15.03.2022.
//

import Foundation

public protocol RequestBuilderProtocol {
    
    func build() throws -> Request
    
}
