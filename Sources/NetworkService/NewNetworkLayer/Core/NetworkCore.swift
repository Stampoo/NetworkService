//
//  NetworkCore.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

final class NetworkCore {
    
    // MARK: - Private properties
    
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Internal methods
    
    func loadRequest(from requestParameters: () throws -> RequestProtocol,
                     onLoadComplete: @escaping (Response) -> Void) throws {
        dataTask = session.dataTask(with: try requestParameters().getRequest()) { data, response, error in
            let response = Response(data: data, response: response, error: error)
            onLoadComplete(response)
        }
        dataTask?.resume()
    }

}
