//
//  File.swift
//  
//
//  Created by fivecoil on 23.10.2020.
//

import Foundation

open class OperationEntity<Model>: EntityService {
    
    // MARK: - Typealias
    
    public typealias Model = Model
    
    // MARK: - Private properties
    
    private var completionHandler: ((Model) -> Void)?
    private var errorHandler: ((Error) -> Void)?
    private var writtenData: Model?
    private var writtenError: Error?

    
    // MARK: - Public methods
    
    @discardableResult
    public func onCompleted(_ completionHandler: ((Model) -> Void)?) -> Self {
        guard let dataInEntity = writtenData else {
            return self
        }
        self.completionHandler = completionHandler
        self.completionHandler?(dataInEntity)
        return self
    }
    
    @discardableResult
    public func onError(_ errorHandler: ((Error) -> Void)?) -> Self {
        guard let errorInEntity = writtenError else {
            return self
        }
        self.errorHandler = errorHandler
        self.errorHandler?(errorInEntity)
        return self
    }
    
    @discardableResult
    func add(_ data: Model) -> Self {
        writtenData = data
        return self
    }
    
    @discardableResult
    func add(_ error: Error) -> Self {
        writtenError = error
        return self
    }
    
}

extension OperationEntity: RequestServiceDelegate {
    
    func contentDidLoad(_ response: NetworkResponse) {
        let handlingCycle = HandlingCycle(response)
        handlingCycle.startResponseCycle()
    }

}
