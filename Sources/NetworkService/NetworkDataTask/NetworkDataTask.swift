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
    private var responseContext = ResponseContext<Response>(storedResult: .error(NSError()))
    
    // MARK: - Public methods
    
    public func startTask(url: URL?,
                   method: RequestMethod,
                   parameters: ParametersEncodingType = .query(parameters: [:]),
                          headers: [String: String] = [:]) throws -> ResponseContext<Response> {
        session.start(url: url, method: method, parameters: parameters, headers: headers)
        session.onComplete { [weak self] response in
            self?.responseContext.emit(.data(response))
        }
        return responseContext
    }
    
}
