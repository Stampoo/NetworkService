//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

public protocol EntityService {
    
    associatedtype Model
        
    @discardableResult
    func onCompleted(_ completeHandler: ((Model) -> Void)?) -> Self
    
    @discardableResult
    func onError(_ errorHandler: ((Error) -> Void)?) -> Self

}
