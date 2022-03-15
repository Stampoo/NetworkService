//
//  NetworkDataTask.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

open class NetworkDataTask {

    // MARK: - Private properties
    
    private let core = NetworkCore()
    private var onComplete: ((Response) -> Void)?
    private var responseContext = Context<Response>()
    
    // MARK: - Public methods
    
    public func startTask(url: URL?,
                          method: RequestMethod,
                          parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) -> Context<Response> {
        DrainObjectTester.saveWeakReference(on: self)
        do {
            let requestBuilder = try RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
            try core.loadRequest(from: requestBuilder.request) { [responseContext] response in
                responseContext.send(response)
                DrainObjectTester.saveWeakReference(on: responseContext)
            }
        }
        catch {
            responseContext.send(error)
        }
        return responseContext
    }

}
