//
//  EventTransceiverProtocol.swift
//  
//
//  Created by Князьков Илья on 17.03.2022.
//

public protocol EventTransceiverProtocol: AnyObject {

    associatedtype Output
    associatedtype AbstractError: Error
    associatedtype AbsctractPublisher

    var lastSendedData: Output? { get }
    var lastSendedError: AbstractError? { get }
    var wrappedPublisher: AbsctractPublisher { get }

    func subscribe(_ subscription: @escaping (Result<Output, AbstractError>) -> Void)
    func send(newValue: Output)
    func send(error: AbstractError)

}
