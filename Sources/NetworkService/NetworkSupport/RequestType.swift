//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

enum RequestType {
    case request
    case requestWithParam(_ param: [String: Any])
    case requestWithParamAndHeaders(_ param: [String: Any], _ header: [String: Any])
}
