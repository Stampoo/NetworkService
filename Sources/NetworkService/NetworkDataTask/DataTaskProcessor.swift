//
//  DataTaskProcessor.swift
//  
//
//  Created by Князьков Илья on 09.03.2022.
//

import Foundation

open class DataTaskProcessor {
    
    // MARK: - Nested types
    
    private enum Errors: Error {
        case dataWasNotFound
    }
    
    // MARK: - Private properties
    
    private let networkDataTask = NetworkDataTask()
    
    // MARK: - Initialization
    
    public init() {
        DrainObjectTester.saveWeakReference(on: self)
    }
    
    // MARK: - Public methods
    
    public func startTask(url: URL?,
                          method: RequestMethod,
                          parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) -> AnyResultDecoder<Response> {
        let requestBuilder = RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
        return startDataTask(requestBuilder: requestBuilder)
    }
    
    public func startTask<Output: Decodable>(url: URL?,
                                             method: RequestMethod,
                                             parameters: ParametersEncodingType = .query(parameters: [:]),
                                             headers: [String: String] = [:]) -> AnyResponseContex<Output> {
        let requestBuilder = RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
        return startDataTask(requestBuilder: requestBuilder)
            .decode(on: Output.self)
        
    }
    
    public func startTask(context: AnyResponseContex<RequestBuilderProtocol>) -> AnyResponseContex<Response> {
        networkDataTask.startTask(context: context)
    }
    
    // MARK: - Private methods
    
    private func startDataTask(requestBuilder: RequestBuilderProtocol) -> AnyResponseContex<Response> {
        networkDataTask.startTask(requestBuilder: requestBuilder)
    }
    
}
