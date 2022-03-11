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
    private var onComplete: ((Response) -> Void)?
    
    // MARK: - Public methods
    
    public func start(url: URL?,
                      method: RequestMethod,
                      parameters: ParametersEncodingType,
                      headers: [String: String]) {
        DrainObjectTester.saveWeakReference(on: self)
        do {
            try startSession(url: url, method: method, parameters: parameters, headers: headers)
        }
        catch {
            onComplete?(Response(data: nil, response: nil, error: error))
        }
    }
    
    // MARK: - Internal methods
    
    func onComplete(_ onComplete: @escaping (Response) -> Void) {
        self.onComplete = onComplete
    }
    
    // MARK: - Private methods
    
    private func startSession(url: URL?,
                      method: RequestMethod,
                      parameters: ParametersEncodingType,
                      headers: [String: String]) throws {
        let requestBuilder = try RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
        try core.loadRequest(from: requestBuilder.request) { [self] response in
            self.onComplete?(response)
        }
    }
    
}
