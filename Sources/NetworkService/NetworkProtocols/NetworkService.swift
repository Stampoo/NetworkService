//
//  File.swift
//  
//
//  Created by fivecoil on 23.10.2020.
//

import Foundation

open class NetworkService<Input, Output> {
    
    var nextService: NetworkService {
        fatalError("override this property!")
    }
    
    func throwNext(_ data: NetworkResponse) -> OperationEntity<Output> {
        fatalError("override this method!")
    }

}
