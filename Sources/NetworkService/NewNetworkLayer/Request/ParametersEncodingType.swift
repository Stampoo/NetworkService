//
//  ParametersEncodingType.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

public enum ParametersEncodingType {
    
    case json(parameters: [String: Any])
    case query(parameters: [String: Any])

}
