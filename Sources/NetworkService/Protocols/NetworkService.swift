//
//  File.swift
//  
//
//  Created by fivecoil on 23.10.2020.
//

import Foundation

open class NetworkService<Input, Output> {
    
    func throwNext(_ data: Response) -> OperationEntity<Output> {
        fatalError("override this method!")
    }

}
