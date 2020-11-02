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
    
    // MARK: - Public properties
    
    private(set) var completionHandler: ((Model) -> Void)?
    private(set) var errorHandler: ((Error) -> Void)?
    private(set) var writtenData: Model?
    private(set) var writtenError: Error?
    public var count = 0

    
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
        completionHandler?(data)
        return self
    }
    
    @discardableResult
    func add(_ error: Error) -> Self {
        writtenError = error
        errorHandler?(error)
        return self
    }
    
    func devouring(_ entity: OperationEntity<Model>) {
        if let data = entity.writtenData {
            add(data)
        }
        if let error = entity.writtenError {
            add(error)
        }
    }
    
}

extension OperationEntity: RequestServiceDelegate {
    
    func contentDidLoad(_ response: NetworkResponse) { }

}
