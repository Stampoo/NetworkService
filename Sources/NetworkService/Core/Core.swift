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
    
    func request(on route: Route,
                 param: Parameters = .url(),
                 headers: Json = [:]) {
        guard let urlRequest = request(from: route, param: param, headers: headers) else {
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
    
    private func request(from route: NetworkRoute,
                         param: Parameters = .url(),
                         headers: Json = [:]) -> URLRequest? {
        guard let url = route.completeURL else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = route.requestMethod.rawValue
        addParam(param, request: &request)
        addHeaders(headers, request: &request)
        return request
    }
    
    private func addParam(_ param: Parameters, request: inout URLRequest) {
        guard let url = request.url,
            var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return
        }
        switch param {
        case .string(let params):
            urlComponent.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
            request.httpBody = urlComponent.query?.data(using: .utf8)
        case .json(let params):
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        case .url(let params):
            urlComponent.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
            request.url = urlComponent.url
        }
    }
    
    private func addHeaders(_ headers: Json, request: inout URLRequest) {
        headers.forEach { request.addValue($0, forHTTPHeaderField: "\($1)") }
    }
    
}
