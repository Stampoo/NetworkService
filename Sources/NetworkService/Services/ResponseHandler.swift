//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

open class ResponseHandler: NetworkService<NetworkResponse, NetworkResponse> {
    
    // MARK: - Public properties
    
    override var nextService: NetworkService<NetworkResponse, NetworkResponse> {
        .init()
    }
    
    // MARK: - Public methods
    
    override func throwNext(_ data: NetworkResponse) -> OperationEntity<NetworkResponse> {
        .init()
    }
    
    // MARK: - Private methods
    
    func codeHandler(_ code: Int,
                     data: NetworkResponse) -> OperationEntity<NetworkResponse> {
        switch code {
        case 200..<300:
            return nextService.throwNext(data)
        case 400:
            return OperationEntity<NetworkResponse>().add(NetworkHTTPError.badRequest)
        default:
            return OperationEntity<NetworkResponse>()
                .add(NetworkHTTPError
                    .unknownError(code))
        }
    }
    
}
