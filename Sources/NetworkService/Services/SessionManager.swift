//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

open class SessionManager<Route: NetworkRoute> {
    
    // MARK: - Public properties
    
    var response: NetworkResponse?
    var entity: OperationEntity<Json> = .init()
    
    // MARK: - Private properties
    
    private let requestService = RequestService<Route>()
    
    // MARK: - Initializers
    
    public init() {
        requestService.delegate = self
    }
    
    @discardableResult
    public func startSession(on request: Route) -> OperationEntity<Json>? {
        requestService.request(on: request)
        return entity
    }

}

// MARK: - Extensions

extension SessionManager: RequestServiceDelegate {

    func contentDidLoad(_ response: NetworkResponse) {
        let handlingCycle = HandlingCycle(response)
        entity.devouring(handlingCycle.startResponseCycle().throwNext(response))
        entity.count += 1
        print(entity.count)
        print(entity)
    }
    
}
