//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

final class ParametersEncoder {

    // MARK: - Constants

    private enum Constants: String {
        case json = "application/json"
        case string = "application/x-www-form-urlencoded; charset=utf-8"
    }

    // MARK: - Public properties

    static let shared = ParametersEncoder()
    
    // MARK: - Initializers
    
    private init() { }

    // MARK: - Public methods

    func addParametersTo(request: inout URLRequest,
                         with parameters: [String: Any]?,
                         type: ParametrCodingType) {
        guard let parameters = parameters else {
            return
        }
        switch type {
        case .body:
            addParametersToBodyFromString(parameters, &request)
        case .json:
            addParametersToBodyFromDict(parameters, &request)
        case .url:
            addParametersToURLFromDict(parameters, &request)
        }
    }

    //MARK: - Private methods

    private func addParametersToBodyFromString(_ parameters: [String: Any],
                                               _ request: inout URLRequest) {
        var count = 0
        var bodyString = ""
        for (key, value) in parameters {
            count += 1
            if count >= parameters.count {
                bodyString += "\(key)=\(value)"
            } else {
                bodyString += "\(key)=\(value)&"
            }
        }
        request.httpBody = bodyString.data(using: .utf8)
    }

    private func addParametersToBodyFromDict(_ parameters: [String: Any],
                                             _ request: inout URLRequest) {
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters,
                                                       options: [])
    }

    private func addParametersToURLFromDict(_ parameters: [String: Any],
                                            _ request: inout URLRequest) {
        guard let url = request.url,
            var urlComponents = URLComponents(
                url: url,
                resolvingAgainstBaseURL: false
            ) else {
                return
        }
        urlComponents.queryItems = parameters.map {
            .init(name: $0.key, value: "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
        }
        request.url = urlComponents.url
    }

}

