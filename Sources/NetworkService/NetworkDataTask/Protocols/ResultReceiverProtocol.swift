//
//  ResultReceiverProtocol.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

import Foundation

public protocol ResultReceiverProtocol {
    
    associatedtype Output
    
    @inlinable
    @discardableResult
    func onComplete(_ onComplete: (Output) -> Void) -> Self
    
    @inlinable
    @discardableResult
    func onError(_ onError: (Error) -> Void) -> Self
    
}
