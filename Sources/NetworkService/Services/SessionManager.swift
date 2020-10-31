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
    
    // MARK: - Private properties
    
    private let requestService = RequestService<Route>()
    
    // MARK: - Initializers
    
    public init() {
        requestService.delegate = self
    }
    
    func startSession(on request: Route) {
        requestService.request(on: request)
    }

}

// MARK: - Extensions

extension SessionManager: RequestServiceDelegate {

    func contentDidLoad(_ response: NetworkResponse) {
        print(response)
    }
    
}
