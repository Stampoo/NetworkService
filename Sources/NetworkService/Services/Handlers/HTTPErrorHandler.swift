//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

open class HTTPErrorHandler<Output>: NetworkService<NetworkResponse, Output> {
    
    // MARK: - Constants
    
    private enum Constants: Int {
        case specialCode = 99999
        case badRequest = 400
        case notFound = 404
        case success = 200
    }
    
    // MARK: - Public properties
    
    let nextService: NetworkService<NetworkResponse, Output>
    
    // MARK: - Initializers
    
    public init(next: NetworkService<NetworkResponse, Output>) {
        nextService = next
    }
    
    // MARK: - Public methods
    
    override func throwNext(_ data: NetworkResponse) -> OperationEntity<Output> {
        return codeHandler(data)
    }
    
    // MARK: - Private methods
    
    func codeHandler(_ data: NetworkResponse) -> OperationEntity<Output> {
        let response = data.response as? HTTPURLResponse
        let code = response?.statusCode ?? 99999
        let entity = OperationEntity<Output>()
        switch code {
        case Constants.success.rawValue:
            return nextService.throwNext(data)
        case Constants.badRequest.rawValue:
            return entity.add(NetworkHTTPError.badRequest)
        case Constants.specialCode.rawValue:
            return entity
                .add(NetworkHTTPError.unknownError(Constants.specialCode.rawValue))
        default:
            return entity.add(NetworkHTTPError.unknownError(code))
        }
    }
    
}
