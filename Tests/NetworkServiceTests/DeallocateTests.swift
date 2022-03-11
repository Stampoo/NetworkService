//
//  DeallocateTests.swift
//  
//
//  Created by Князьков Илья on 10.03.2022.
//

import XCTest
@testable import NetworkService

final class DeallocateTests: XCTestCase {
    
    func testOnSuccessRequestReceived() {
        let expectation = expectation(description: "Response successful received")
        DataTaskProcessor()
            .startTask(url: TestRoute.url, method: .get)
            .decode(on: Test.self)
            .onComplete { _ in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    print(DrainObjectTester.getAliveObjectCount())
                }
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testOnSucessDeallocDataTaskServices() {
        XCTAssertEqual(DrainObjectTester.getAliveObjectCount(), 0)
    }

}
