//
//  File.swift
//  
//
//  Created by fivecoil on 25.10.2020.
//

import Foundation

open class RequestService<Route: NetworkRoute> {
    
    // MARK: - Typealias
    
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Public properties
    
    weak var delegate: RequestServiceDelegate?
    
    // MARK: - Private properties
    
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var responseFromServer: NetworkResponse? {
        willSet {
            if let response = newValue {
                delegate?.contentDidLoad(response)
            }
        }
    }
    
    // MARK: - Public methods
    
    func request(on route: Route) {
        guard let urlRequest = request(from: route) else {
            return
        }
        dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.responseFromServer = .init(data: data, error: error, response: response)
        }
        dataTask?.resume()
    }
    
    // MARK: - Private methods
    
    private func request(from route: NetworkRoute) -> URLRequest? {
        guard let url = route.completeURL else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = route.requestMethod.rawValue
        switch route.requestType {
        case .request:
            ParametersEncoder.shared.addParametersTo(request: &request, with: nil, type: .string)
        case let .requestWithParam(param):
            ParametersEncoder.shared.addParametersTo(request: &request, with: param, type: .string)
        case let .requestWithParamAndHeaders(param, _):
            ParametersEncoder.shared.addParametersTo(request: &request, with: param, type: .string)
        }
        return request
    }

}
