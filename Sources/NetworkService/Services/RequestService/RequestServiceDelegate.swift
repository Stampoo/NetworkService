//
//  File.swift
//  
//
//  Created by Илья Князьков on 31/10/2020.
//

import Foundation

protocol RequestServiceDelegate: class {
    func contentDidLoad(_ response: NetworkResponse?)
}
