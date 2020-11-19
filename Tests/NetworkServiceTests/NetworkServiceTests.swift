import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {
    
    // MARK: - Get
    
    private let networkService = SessionManager<TestRoute>()
    
    func testRequest() {
        let expectationResult = XCTestExpectation(description: "My expectation")
        networkService.startSession(on: .test)
            .onCompleted { _ in
                expectationResult.fulfill()
            }.onError {
                XCTFail("\($0)")
        }
        wait(for: [expectationResult], timeout: 3.0)
    }
    
}

// MARK: - Moke data

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
