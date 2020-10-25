//
//  File.swift
//  
//
//  Created by fivecoil on 23.10.2020.
//

import Foundation

open class NetworkService<Input, Output> {
    
    var nextService: NetworkService = NetworkService()
    
    func throwNext(_ data: NetworkResponse) -> OperationEntity<Output> {
        OperationEntity()
    }

}
