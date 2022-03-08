//
//  AnyResultReceiver.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//


/// - Type erasure for ResultReceiverProtocol
open class AnyResultReceiver<Output>: ResultReceiverProtocol {
    
    @inlinable
    @discardableResult
    public func onComplete(_ onComplete: (Output) -> Void) -> Self {
        self
    }
    
    @inlinable
    @discardableResult
    public func onError(_ onError: (Error) -> Void) -> Self {
        self
    }
    
}
