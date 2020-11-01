//
//  File.swift
//  
//
//  Created by Илья Князьков on 01/11/2020.
//

import Foundation

open class ContentHandler: NetworkService<NetworkResponse, Json> {
    
    // MARK: - Public properties
    
    override func throwNext(_ data: NetworkResponse) -> OperationEntity<Json> {
        return dataHandling(from: data)
    }
    
    // MARK: - Private methods
    
    private func dataHandling(from responce: NetworkResponse) -> OperationEntity<Json> {
        let entity = OperationEntity<Json>()
        guard let data = responce.data else {
                return entity.add(DataHandleError.dataHandleError)
        }
        do {
            let json = try JSONSerialization
                .jsonObject(with: data, options: .allowFragments) as? [String: Any]
            entity.add(json ?? Json())
        }
        catch {
            entity.add(DataHandleError.unknowError(error))
        }
        return entity
    }

}
