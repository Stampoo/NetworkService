//
//  DataTaskResultHandler.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

open class DataTaskResultHandler<Output>: AnyResultReceiver<Output> {
    
    @inlinable
    @discardableResult
    public override func onComplete(_ onComplete: (Output) -> Void) -> Self {
        self
    }
    
    @inlinable
    @discardableResult
    public override func onError(_ onError: (Error) -> Void) -> Self {
        self
    }
}


