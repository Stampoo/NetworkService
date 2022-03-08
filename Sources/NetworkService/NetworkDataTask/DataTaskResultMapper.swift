//
//  DataTaskResultMapper.swift
//  
//
//  Created by Князьков Илья on 08.03.2022.
//

open class DataTaskResultMapper {
    
}

extension DataTaskResultMapper: ResultMapperProtocol {
    
    public func map<Output: Decodable>(on type: Output.Type) throws -> AnyResultReceiver<Output> {
        DataTaskResultHandler<Output>()
    }
    
    public func map<Input, Output: Decodable>(_ transform: (Input) throws -> Output) rethrows ->  AnyResultReceiver<Output> {
        DataTaskResultHandler<Output>()
    }
    
}
