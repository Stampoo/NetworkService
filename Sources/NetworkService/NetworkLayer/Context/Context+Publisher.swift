//
//  Context+Publisher.swift
//  
//
//  Created by Князьков Илья on 17.03.2022.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
extension Context: EventTransceiverProtocol {

    public typealias Output = Input
    public typealias AbstractError = Error
    public typealias AbsctractPublisher = AnyPublisher<Output, AbstractError, Context>
    
    public var wrappedPublisher: AbsctractPublisher {
        AbsctractPublisher(eventTransceiver: self)
    }
    
    public func subscribe(_ subscription: @escaping (Result<Input, Error>) -> Void) {
        onComplete { input in
            subscription(.success(input))
        }
        onError { error in
            subscription(.failure(error))
        }
    }
    
    public func send(newValue: Input) {
        send(newValue)
    }
    
    public func send(error: Error) {
        send(error)
    }

}
