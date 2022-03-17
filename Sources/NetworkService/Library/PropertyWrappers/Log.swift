//
//  Log.swift
//  
//
//  Created by Князьков Илья on 12.03.2022.
//

import Foundation

@propertyWrapper
final public class Log<Value> {
    
    public var wrappedValue: Value {
        get {
            getValue()
        }
        set {
            setValue(value: newValue)
        }
    }
    
    private var value: Value
    
    public init(wrappedValue value: Value) {
        self.value = value
    }

}

// MARK: - Private methods

private extension Log {
    
    func getValue() -> Value {
        value
    }
    
    func setValue(value: Value) {
        self.value = value
        print((value as AnyObject).description as Any)
    }
    
}
