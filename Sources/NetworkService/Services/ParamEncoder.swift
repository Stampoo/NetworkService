//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

final class ParametersEncoder {

    //MARK: - Constants

    private enum Constants: String {
        case json = "application/json"
        case string = "application/x-www-form-urlencoded; charset=utf-8"
    }


    //MARK: - Public properties

    static let shared = ParametersEncoder()


    //MARK: - Public methods

    func addParametersTo(request: inout URLRequest,
                         with parameters: [String: Any]?,
                         type: Parameters) {
        guard let parameters = parameters else {
            return
        }
        switch type {
        case .string:
            addParametersToBodyFromString(parameters: parameters, request: &request)
        case .json:
            addParametersToBodyFromDict(parameters: parameters, request: &request)
        case .url:
            addParametersToURLFromDict(parameters: parameters, request: &request)
        }
    }


    //MARK: - Private methods

    private func addParametersToBodyFromString(parameters: [String: Any],
                                               request: inout URLRequest) {
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
        let encodeString = bodyString.data(using: .utf8)
        request.httpBody = encodeString
    }

    private func addParametersToBodyFromDict(parameters: [String: Any],
                                             request: inout URLRequest) {
        let json = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = json
    }

    private func addParametersToURLFromDict(parameters: [String: Any],
                                            request: inout URLRequest) {
        guard let url = request.url,
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return
        }
        urlComponents.queryItems = []
        for (key, value) in parameters {
            let formattedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let urlQueryItem = URLQueryItem(name: key, value: formattedValue)
            urlComponents.queryItems?.append(urlQueryItem)
        }
        request.url = urlComponents.url
    }

}

