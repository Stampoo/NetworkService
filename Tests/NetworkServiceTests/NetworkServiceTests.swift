import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {
    
    // MARK: - Get
    
    private let networkService = SessionManager<TestRoute>()
    
    func testForTestRequest() {
        let expectationResult = XCTestExpectation(description: "Json loading success!")
        testRequest()
            .onCompleted { _ in
                expectationResult.fulfill()
            }.onError {
                XCTFail($0.localizedDescription)
        }
        wait(for: [expectationResult], timeout: 3.0)
    }
    
    func testRequest() -> OperationEntity<Test> {
        networkService.startSession(on: .test)
    }
    
}

enum TestRoute {
    case test
}

extension TestRoute: NetworkRoute {
    
    var baseLink: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        "/todos/1"
    }
    
    var requestType: RequestType {
        .request
    }
    
    var requestMethod: RequestMethod {
        .GET
    }

}

struct Test: Codable { }
