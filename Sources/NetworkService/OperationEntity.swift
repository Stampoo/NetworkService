//
//  File.swift
//  
//
//  Created by fivecoil on 23.10.2020.
//

import Foundation

open class OperationEntity<Model> {
    
    // MARK: - Private properties
    
    private var completionHandler: ((Model) -> Void)?
    private var errorHandler: ((Error) -> Void)?
    private var writtenData: Model?
    private var writtenError: Error?

    
    // MARK: - Public methods
    
    func onComplete(_ completionHandler: ((Model) -> Void)?) -> Self {
        guard let dataInEntity = writtenData else {
            return self
        }
        self.completionHandler = completionHandler
        self.completionHandler?(dataInEntity)
        return self
    }
    
    func onError(_ errorHandler: ((Error) -> Void)?) -> Self {
        guard let errorInEntity = writtenError else {
            return self
        }
        self.errorHandler = errorHandler
        self.errorHandler?(errorInEntity)
        return self
    }
    
}
