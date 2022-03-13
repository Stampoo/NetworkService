//
//  QueuePerformProtocol.swift
//  
//
//  Created by Князьков Илья on 14.03.2022.
//

import Foundation

protocol QueuePerformProtocol {
    
    associatedtype Input
    
    func perform(in queue: DispatchQueue) -> AnyResponseContex<Input>
    
}
