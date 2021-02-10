//
//  File.swift
//  
//
//  Created by Илья Князьков on 10.02.2021.
//

import Foundation

public struct Event<Model> {
    
    // MARK: - Public methods
    
    var didChanges = [Closure<Model>?]()
    var model: Model?
    
    mutating func add(_ model: Model) {
        self.model = model
        do { didChanges.forEach { $0?(model) } }
    }
    
    mutating func addListener(_ block: Closure<Model>?) {
        didChanges.append(block)
    }

}
