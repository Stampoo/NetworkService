//
//  NetworkDataTask.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

open class NetworkDataTask {

    // MARK: - Private properties
    
    private let session = NetworkSession()
    private var responseContext = Context<Response>()
    
    // MARK: - Public methods
    
    public func startTask(url: URL?,
                   method: RequestMethod,
                   parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) -> Context<Response> {
        session.start(url: url, method: method, parameters: parameters, headers: headers)
        session.onComplete { [responseContext] response in
            responseContext.send(response)
        }
        return responseContext
    }
    
}
