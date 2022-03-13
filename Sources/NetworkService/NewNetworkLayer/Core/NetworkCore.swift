//
//  NetworkCore.swift
//  
//
//  Created by Князьков Илья on 07.03.2022.
//

import Foundation

final class NetworkCore: NSObject {
    
    // MARK: - Private properties
    
    private lazy var session = URLSession(configuration: .default)
    private var activeTasks: Set<URLSessionDataTask?> = []
    private var observer: NSKeyValueObservation?
    
    // MARK: - Internal methods
    
    func loadRequest(from requestParameters: RequestProtocol,
                     onLoadComplete: @escaping (Response) -> Void) throws {
        DrainObjectTester.saveWeakReference(on: self)
        let dataTask = session.dataTask(with: try requestParameters.getRequest()) { data, response, error in
            let response = Response(data: data, response: response, error: error)
            onLoadComplete(response)
        }
        observer = dataTask.observe(\.response) { [weak self] loadedTask, _ in
            self?.activeTasks.remove(loadedTask)
        }
        activeTasks.insert(dataTask)
        dataTask.resume()
    }

}
