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
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Public methods
    
    public func startTask(url: URL?,
                          method: RequestMethod,
                          parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) -> AnyResponseContex<Response> {
        networkDataTask
            .startTask(url: url, method: method, parameters: parameters, headers: headers)
    }
    
    public func startTask<Output: Decodable>(url: URL?,
                          method: RequestMethod,
                          parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) -> AnyResponseContex<Output> {
        networkDataTask
            .startTask(url: url, method: method, parameters: parameters, headers: headers)
            .decode(on: Output.self)
    }
    
}
