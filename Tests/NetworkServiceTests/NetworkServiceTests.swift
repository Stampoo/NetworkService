import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {

    func testForTestRequest() {
        let session = NetworkSession()
        session.start(url: TestRoute.url, method: .get, parameters: .query(parameters: [:]), headers: [:])
        let expectationCase = expectation(description: "Test")
        session.onComplete {
            expectationCase.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

enum TestRoute {
    
    private static let baseLink = "https://jsonplaceholder.typicode.com"
    private static let path = "/todos/1"
    static let url = URL(string: baseLink + path)

}



struct Test: Codable { }
