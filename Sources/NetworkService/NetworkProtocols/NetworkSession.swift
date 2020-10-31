//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

public protocol NetworkSession {
    
    associatedtype Route: NetworkRoute
    
    var manager: SessionManager<Route> { get }

}
