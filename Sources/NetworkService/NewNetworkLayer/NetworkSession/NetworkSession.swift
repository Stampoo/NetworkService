//
//  NetworkSession.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

open class NetworkSession {
    
    // MARK: - Private properties
    
    private let core = NetworkCore()
    private var responseContext: ResponseContext<Response>?
    
    // MARK: - Public methods
    
    public func start(url: URL?,
                      method: RequestMethod,
                      parameters: ParametersEncodingType,
                      headers: [String: String]) {
        do {
            try startSession(url: url, method: method, parameters: parameters, headers: headers)
        }
        catch {
            responseContext = ResponseContext<Response>(storedResult: .error(error))
        }
    }
    
    // MARK: - Private methods
    
    func startSession(url: URL?,
                      method: RequestMethod,
                      parameters: ParametersEncodingType,
                      headers: [String: String]) throws {
        let requestBuilder = try RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
        try core.loadRequest(from: requestBuilder.request) { [weak self] response in
            self?.responseContext = ResponseContext<Response>(storedResult: .data(response))
        }
    }
    
}
