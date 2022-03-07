//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

open class SessionManager<Route: NetworkRoute> {
    
    // MARK: - Public properties
    
    private var response: Response?
    
    // MARK: - Private properties
    
    private let requestService = Core<Route>()
    
    // MARK: - Initializers
    
    public init() { }
    
    @discardableResult
    public func startSession<Model: Codable>(on request: Route,
                                             param: Parameters = .url(),
                                             headers: Json = [:]) -> Observer<Model> {
        let newEntity = Observer<Model>()
        requestService.didDownloadEvent.addListener { response in
            let handlingCycle = HandlingCycle<Model>(response)
            newEntity.devouring(handlingCycle.startResponseCycle().throwNext(response))
        }
        requestService.request(on: request, param: param, headers: headers)
        return newEntity
    }

}
