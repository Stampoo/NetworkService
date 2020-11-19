//
//  File.swift
//  
//
//  Created by Илья Князьков on 19/11/2020.
//

import Foundation

enum ParametrCodingType {
    case body
    case url
    case json
}

public struct Parameters {
    let parameters: Json
    let codingType: ParametrCodingType
    
    init(param: Json, _ codingType: ParametrCodingType = .url) {
        parameters = param
        self.codingType = codingType
    }
}
