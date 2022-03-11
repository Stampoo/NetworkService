import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {

    func testForTestRequest() throws {
        let dataTask = DataTaskProcessor()
        let expectationCase = expectation(description: "Test")
        dataTask.startTask(url: TestRoute.url, method: .get)
            .decode(on: Test.self)
            .map { _ in
                return String()
            }
            .onComplete { _ in
                expectationCase.fulfill()
            }

        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
