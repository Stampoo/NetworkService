//
//  ResponseChainProtocol.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

protocol ResponseTransformProtocol {
    
    associatedtype Input

    @inlinable
    @discardableResult
    func map<Output>(_ transform: @escaping (Input) throws -> Output) rethrows -> ResponseContext<Output>

}
