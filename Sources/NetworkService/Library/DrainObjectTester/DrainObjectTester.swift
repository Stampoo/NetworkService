//
//  DrainObjectTester.swift
//  
//
//  Created by Князьков Илья on 11.03.2022.
//

import Foundation

final class WeakContainer {
    
    private(set) weak var object: AnyObject?
    
    init(object: AnyObject) {
        self.object = object
    }
    
}

public struct DrainObjectTester {
    
    private(set) static var weakReferencesCollection: [WeakContainer] = []
    private static var isTestTargetRunning: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    static func saveWeakReference(on object: AnyObject) {
        guard isTestTargetRunning else {
            return
        }
        debugPrint("object \(object) will be incremented as stored")
        let weakContainer = WeakContainer(object: object)
        weakReferencesCollection.append(weakContainer)
    }
    
    public static func getAliveObjectCount() -> Int {
        weakReferencesCollection.compactMap(\.object).count
    }
    
}
