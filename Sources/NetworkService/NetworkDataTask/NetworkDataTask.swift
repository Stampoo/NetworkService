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
    
    public func startTask(requestBuilder: RequestBuilderProtocol) -> Context<Response> {
        DrainObjectTester.saveWeakReference(on: self)
        do {
            try core.loadRequest(from: try requestBuilder.build()) { [responseContext] response in
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
