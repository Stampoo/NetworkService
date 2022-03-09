//
//  DataTaskProcessor.swift
//  
//
//  Created by Князьков Илья on 09.03.2022.
//

import Foundation

open class DataTaskProcessor {
    
    // MARK: - Private properties
    
    private let networkDataTask = NetworkDataTask()
    
    // MARK: - Public methods
    
    public func startTask(url: URL?,
                          method: RequestMethod,
                          parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) -> ResponseContext<Response> {
        networkDataTask
            .startTask(url: url, method: method, parameters: parameters, headers: headers)
    }
    
}