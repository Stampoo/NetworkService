//
//  File.swift
//  
//
//  Created by Илья Князьков on 01/11/2020.
//

import Foundation

open class ErrorHandler<Output>: NetworkService<NetworkResponse, Output> {
    
    // MARK: - Public methods
    
    let nextService: NetworkService<NetworkResponse, Output>
    
    // MARK: - Initializers
    
    public init(next: NetworkService<NetworkResponse, Output>) {
        nextService = next
    }
    
    // MARK: - Public methods
    
    override func throwNext(_ data: NetworkResponse) -> OperationEntity<Output> {
        return handlingError(data)
    }
    
    // MARK: - Private methods
    
    private func handlingError(_ data: NetworkResponse) -> OperationEntity<Output> {
        guard let error = data.error else {
            print("Запрос выполнен успешно")
            return nextService.throwNext(data)
        }
        print("Ошибка в запросе: \(error.localizedDescription)")
        return OperationEntity<Output>().add(error)
    }

}
