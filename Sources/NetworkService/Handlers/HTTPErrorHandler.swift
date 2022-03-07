//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

open class HTTPErrorHandler<Output>: NetworkService<Response, Output> {
    
    // MARK: - Constants
    
    private enum Constants: Int {
        case badRequest = 400
        case notFound = 404
        case success = 200
    }
    
    // MARK: - Public properties
    
    let nextService: NetworkService<Response, Output>
    
    // MARK: - Initializers
    
    public init(next: NetworkService<Response, Output>) {
        nextService = next
    }
    
    // MARK: - Public methods
    
    override func throwNext(_ data: Response) -> Observer<Output> {
        return codeHandler(data)
    }
    
    // MARK: - Private methods
    
    func codeHandler(_ data: Response) -> Observer<Output> {
        let entity = Observer<Output>()
        switch data.code {
        case Constants.success.rawValue:
            return nextService.throwNext(data)
        case Constants.badRequest.rawValue:
            return entity.add(NSError())
        default:
            debugPrint(data.response ?? URLResponse())
            return entity.add(NSError())
        }
    }
    
}
