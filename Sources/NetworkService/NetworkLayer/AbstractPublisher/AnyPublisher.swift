//
//  AnyPublisher.swift
//  
//
//  Created by Князьков Илья on 17.03.2022.
//

import Combine

@available(iOS 13, macOS 10.15, *)
public struct AnyPublisher<Model, AbstractError,
                           AbstractEventTransceiver: EventTransceiverProtocol>: Publisher
where AbstractEventTransceiver.AbstractError == AbstractError,
      AbstractEventTransceiver.Output == Model {
    
    // MARK: - Nested Types

    public typealias Output = Model
    public typealias Failure = AbstractError

    // MARK: - Pirvate Properties

    private weak var eventTransceiver: AbstractEventTransceiver?

    // MARK: - Initialization

    init(eventTransceiver: AbstractEventTransceiver) {
        self.eventTransceiver = eventTransceiver
    }

    // MARK: - Publisher

    public func receive<AbstractSubscriber: Subscriber>(subscriber: AbstractSubscriber)
    where AnyPublisher.Failure == AbstractSubscriber.Failure, AnyPublisher.Output == AbstractSubscriber.Input {

        let subscription = AnySubscription(eventTransceiver: eventTransceiver, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }

}
