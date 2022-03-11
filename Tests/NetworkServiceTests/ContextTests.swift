//
//  ContextTests.swift
//  
//
//  Created by Князьков Илья on 10.03.2022.
//

import XCTest
@testable import NetworkService

final class ContextTests: XCTestCase {
    
    func testAsyncWriteInContext() {
        let queue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier ?? "").queue.test")
        let context = Context<Int>()
        let expectation = expectation(description: "Saved data and data equal")
        let savedData = 3
        var isEnded = false
        queue.async {
            context.send(1)
            queue.async {
                context.send(2)
            }
            queue.async {
                context.send(savedData)
            }
        }
        context.map { data in
            guard isEnded else {
                isEnded = true
                expectation.fulfill()
                XCTAssertEqual(data, 1)
                return
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
