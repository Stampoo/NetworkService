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
    private let requestTransformer: RequestTransformer
    
    // MARK: - Initialization
    
    public init(requestTransformer: RequestTransformer = RequestTransformer()) {
        self.requestTransformer = requestTransformer
        DrainObjectTester.saveWeakReference(on: self)
    }
    
    // MARK: - Public methods
    
    public func startTask(url: URL?,
                          method: RequestMethod,
                          parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) -> AnyResultDecoder<Response> {
        let requestBuilder = RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
        return networkDataTask.startTask(context: requestTransformer.transform(input: requestBuilder))
    }
    
    public func startTask<Output: Decodable>(url: URL?,
                                             method: RequestMethod,
                                             parameters: ParametersEncodingType = .query(parameters: [:]),
                                             headers: [String: String] = [:]) -> AnyResponseContex<Output> {
        let requestBuilder = RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
        return networkDataTask.startTask(context: requestTransformer.transform(input: requestBuilder))
            .decode(on: Output.self)
        
    }

}
