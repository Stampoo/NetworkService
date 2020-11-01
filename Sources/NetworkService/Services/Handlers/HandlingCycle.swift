//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

open class HandlingCycle {
    
    // MARK: - Private properties
    
    private let response: NetworkResponse
    
    // MARK: - Initializers
    
    public init(_ response: NetworkResponse) {
        self.response = response
    }
    
    @discardableResult
    func startResponseCycle() -> NetworkService<NetworkResponse, Json> {
        let contentHandler = ContentHandler()
        let errorHandler = ErrorHandler(next: contentHandler)
        let responseHandler = HTTPErrorHandler(next: errorHandler)
        return responseHandler
    }

}
