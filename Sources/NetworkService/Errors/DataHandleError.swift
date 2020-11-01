//
//  File.swift
//  
//
//  Created by Илья Князьков on 01/11/2020.
//

import Foundation

public enum DataHandleError {
    case dataHandleError
    case unknowError(_ error: Error)
}

extension DataHandleError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .dataHandleError:
            return "Error map data in Json!"
        case .unknowError(let error):
            return "Unknow data handle error: \(error.localizedDescription)"
        }
    }
    
}
