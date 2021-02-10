//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

public enum RequestType {
    case request
    case requestWithParam(_ param: Json)
    case requestWithHeaders(_ headers: Json)
    case requestWithParamAndHeaders(_ param: Json, _ header: Json)
}
