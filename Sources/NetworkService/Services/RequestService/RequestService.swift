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
            delegate?.contentDidLoad(newValue)
        }
    }
    
    // MARK: - Public methods
    
    @discardableResult
    func request(on route: Route) -> Result<Void, Error> {
        guard let urlRequest = request(from: route) else {
            return .failure(NetworkError.badRequest)
        }
        dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            self.responseFromServer = .init(data: data, error: error, response: response)
        }
        dataTask?.resume()
        return .success(Void())
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
            break
        case .requestWithParam(let param):
            ParametersEncoder.shared.addParametersTo(request: &request,
                                                     with: param.parameters,
                                                     type: param.codingType)
        case .requestWithHeaders(let headers):
            headers.forEach { request.addValue($0.key, forHTTPHeaderField: "\($0.value)") }
        case let .requestWithParamAndHeaders(param, headers):
            headers.forEach { request.addValue($0.key, forHTTPHeaderField: "\($0.value)") }
            ParametersEncoder.shared.addParametersTo(request: &request,
                                                     with: param.parameters,
                                                     type: param.codingType)
        }
        return request
    }

}
