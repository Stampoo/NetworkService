import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {

    func testForTestRequest() {
    }
    
}

enum TestRoute {
    case test
}

extension TestRoute {
    
    var baseLink: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        "/todos/1"
    }
    
}

struct Test: Codable { }
