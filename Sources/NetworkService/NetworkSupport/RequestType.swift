//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

public enum RequestType {
    case request
    case requestWithParam(_ param: Parameters)
    case requestWithHeaders(_ headers: Json)
    case requestWithParamAndHeaders(_ param: Parameters, _ header: Json)
}
