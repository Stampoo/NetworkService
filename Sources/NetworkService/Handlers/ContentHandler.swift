//
//  File.swift
//  
//
//  Created by Илья Князьков on 01/11/2020.
//

import Foundation

open class ContentHandler<Output: Codable>: NetworkService<Response, Output> {
    
    // MARK: - Public properties
    
    override func throwNext(_ data: Response) -> OperationEntity<Output> {
        return dataHandling(from: data)
    }
    
    // MARK: - Private methods
    
    private func dataHandling(from responce: Response) -> OperationEntity<Output> {
        let entity = OperationEntity<Output>()
        guard let data = responce.data else {
                return entity.add(DataHandleError.dataHandleError)
        }
        debugPrint(responce.arrayOfJson.isEmpty ? responce.json : responce.arrayOfJson)
        do {
            let json = try JSONDecoder().decode(Output.self, from: data)
            entity.add(json)
        }
        catch {
            entity.add(DataHandleError.unknowError(error))
        }
        return entity
    }

}
