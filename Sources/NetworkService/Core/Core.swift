//
//  File.swift
//  
//
//  Created by fivecoil on 25.10.2020.
//

import Foundation

final class Core<Route: NetworkRoute> {
    
    // MARK: - Public properties
    
    var didDownloadEvent = Event<Response>()
    
    // MARK: - Private properties
    
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Public methods
    
    func request(on route: Route) {
        guard let urlRequest = request(from: route) else {
            return
        }
        dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            self.didDownloadEvent.add(.init(data: data, error: error, response: response))
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
        case .requestWithParam(let param):
            ParametersEncoder.shared.addParametersTo(request: &request, with: param, type: .string)
        case .requestWithHeaders(let headers):
            headers.forEach { request.addValue($0.key, forHTTPHeaderField: "\($0.value)") }
        case let .requestWithParamAndHeaders(param, headers):
            headers.forEach { request.addValue($0.key, forHTTPHeaderField: "\($0.value)") }
            ParametersEncoder.shared.addParametersTo(request: &request, with: param, type: .string)
        }
        return request
    }

}
