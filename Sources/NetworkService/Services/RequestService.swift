//
//  File.swift
//  
//
//  Created by fivecoil on 25.10.2020.
//

import Foundation

final class RequestService {
    
    // MARK: - Typealias
    
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Private properties
    
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private let parameterEncoder = ParametersEncoder()
    
    // MARK: - Public methods
    
    func request(on route: NetworkRoute, _ completion: @escaping DataTaskCompletion) {
        guard let urlRequest = request(from: route) else {
            return
        }
        dataTask = session.dataTask(with: urlRequest, completionHandler: completion)
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
            parameterEncoder.addParametersTo(request: &request, with: nil, type: .string)
        case let .requestWithParam(param):
            parameterEncoder.addParametersTo(request: &request, with: param, type: .string)
        case let .requestWithParamAndHeaders(param, _):
            parameterEncoder.addParametersTo(request: &request, with: param, type: .string)
        }
        return request
    }

}
