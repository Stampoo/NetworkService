//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

open class HandlingCycle<Model: Codable> {
    
    // MARK: - Private properties
    
    private let response: Response
    
    // MARK: - Initializers
    
    public init(_ response: Response) {
        self.response = response
    }
    
    // MARK: - Public methods
    
    @discardableResult
    func startResponseCycle() -> NetworkService<Response, Model> {
        let contentHandler = ContentHandler<Model>()
        let errorHandler = ErrorHandler(next: contentHandler)
        let responseHandler = HTTPErrorHandler(next: errorHandler)
        return responseHandler
    }

}
