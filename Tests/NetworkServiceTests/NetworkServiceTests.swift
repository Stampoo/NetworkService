import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {

    func testForTestRequest() throws {
        let dataTask = DataTaskProcessor()
        let expectationCase = expectation(description: "Test")
        dataTask.startTask(url: TestRoute.url, method: .get)
            .map(on: Test.self)
            .onComplete { _ in
                expectationCase.fulfill()
            }
    
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}

enum TestRoute {
    
    private static let baseLink = "https://jsonplaceholder.typicode.com"
    private static let path = "/todos/1"
    static let url = URL(string: baseLink + path)

}



struct Test: Codable { }
