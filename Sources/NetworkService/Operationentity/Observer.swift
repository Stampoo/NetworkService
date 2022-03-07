//
//  OperationEntity.swift
//  
//
//  Created by fivecoil on 23.10.2020.
//

import Foundation

open class Observer<Model>: EntityService {
    
    // MARK: - Typealias
    
    public typealias Model = Model
    
    // MARK: - Public properties
    
    private(set) var completionHandler: ((Model) -> Void)?
    private(set) var errorHandler: ((Error) -> Void)?
    private(set) var writtenData: Model?
    private(set) var writtenError: Error?
    private(set) var queue: DispatchQueue = .global(qos: .utility)
    
    // MARK: - Public methods
    
    @discardableResult
    public func inQueue(_ queue: DispatchQueue) -> Self {
        self.queue = queue
        return self
    }
    
    @discardableResult
    public func onCompleted(_ completionHandler: ((Model) -> Void)?) -> Self {
        defer { self.completionHandler = completionHandler }
        guard let dataInEntity = writtenData else {
            return self
        }
        runInQueue {
            completionHandler?(dataInEntity)
        }
        return self
    }
    
    @discardableResult
    public func onError(_ errorHandler: ((Error) -> Void)?) -> Self {
        defer { self.errorHandler = errorHandler }
        guard let errorInEntity = writtenError else {
            return self
        }
        runInQueue { [weak self] in
            self?.errorHandler?(errorInEntity)
        }
        return self
    }
    
    @discardableResult
    func add(_ data: Model) -> Self {
        writtenData = data
        runInQueue { [weak self] in
            self?.completionHandler?(data)
        }
        return self
    }
    
    @discardableResult
    func add(_ error: Error) -> Self {
        writtenError = error
        runInQueue { [weak self] in
            self?.errorHandler?(error)
        }
        return self
    }
    
    func devouring(_ entity: Observer<Model>) {
        if let data = entity.writtenData {
            add(data)
        }
        if let error = entity.writtenError {
            add(error)
        }
    }
    
    // MARK: - Private methods
    
    func runInQueue(_ block: @escaping () -> Void) {
        queue.async {
            block()
        }
    }
    
}