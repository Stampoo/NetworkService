//
//  Parameters.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

public enum Parameters {
    case string(_ json: Json = [:])
    case json(_ json: Json = [:])
    case url(_ json: Json = [:])
}
