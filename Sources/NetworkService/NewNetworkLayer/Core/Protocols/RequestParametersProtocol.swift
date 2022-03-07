//
//  RequestParametersProtocol.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

protocol RequestParametersProtocol {
    
    var body: Data { get }
    var queryItems: [URLQueryItem] { get }
    
}
