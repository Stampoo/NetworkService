//
//  RequestTransformer.swift
//  
//
//  Created by Князьков Илья on 17.03.2022.
//

open class RequestTransformer: TransformerProtocol {
    
    public init() { }
    
    open func transform(input: RequestBuilderProtocol) -> Context<RequestBuilderProtocol> {
        Context<RequestBuilder>()
            .map { requestBuilder in
                RequestBuilder(
                    url: requestBuilder.url,
                    method: requestBuilder.method,
                    parameters: requestBuilder.parameters,
                    headers: requestBuilder.headers
                )
            }
            .send(input)
    }

}
