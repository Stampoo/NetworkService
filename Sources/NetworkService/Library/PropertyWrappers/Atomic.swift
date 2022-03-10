//
//  Atomic.swift
//  
//
//  Created by Князьков Илья on 10.03.2022.
//

import Foundation

@propertyWrapper
final public class Atomic<Value> {
    
    public var wrappedValue: Value {
        get {
            getValue()
        }
        set {
            setValue(value: newValue)
        }
    }
    
    private var value: Value
    private let queue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier ?? "app").atomic.queue")
    
    public init(wrappedValue value: Value) {
        self.value = value
    }
    
    public func mutate(_ transform: (inout Value) -> Void) {
        queue.sync {
            transform(&value)
        }
    }

}

// MARK: - Private methods

private extension Atomic {
    
    func getValue() -> Value {
        queue.sync {
            value
        }
    }
    
    func setValue(value: Value) {
        queue.sync {
            self.value = value
        }
    }
    
}
