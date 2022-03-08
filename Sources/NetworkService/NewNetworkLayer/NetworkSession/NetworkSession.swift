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
    private var responseContext: ResponseContext<Response>? {
        didSet { printDebugInformation() }
    }
    private var onComplete: () -> Void = {}
    
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
    
    func onComplete(_ onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
    }
    
    // MARK: - Private methods
    
    private func startSession(url: URL?,
                      method: RequestMethod,
                      parameters: ParametersEncodingType,
                      headers: [String: String]) throws {
        let requestBuilder = try RequestBuilder(url: url, method: method, parameters: parameters, headers: headers)
        try core.loadRequest(from: requestBuilder.request) { [weak self] response in
            self?.responseContext = ResponseContext<Response>(storedResult: .data(response))
        }
    }
    
    private func printDebugInformation() {
        responseContext?.map { response in
            print(response.code)
            self.onComplete()
        }
    }
    
}
