//
//  AnySubscription.swift
//  
//
//  Created by Князьков Илья on 17.03.2022.
//

import Combine
import Foundation

@available(iOS 13, *)
class AnySubscription<AbstractSubscriber: Subscriber,
                      Model, AbstractError,
                      AbstractEventTransceiver: EventTransceiverProtocol>: Subscription
where AbstractSubscriber.Input == Model,
      AbstractSubscriber.Failure == AbstractError,
      AbstractEventTransceiver.AbstractError == AbstractError,
      AbstractEventTransceiver.Output == Model {

    private weak var eventTransceiver: AbstractEventTransceiver?
    private var subscriber: AbstractSubscriber?

    init(eventTransceiver: AbstractEventTransceiver?, subscriber: AbstractSubscriber) {
        self.eventTransceiver = eventTransceiver
        self.subscriber = subscriber
        subscribeOnNewEvent()
    }

    // MARK: - Subscription

    func request(_ demand: Subscribers.Demand) { }

    func cancel() {
        subscriber = nil
    }

    // MARK: - Private Methods

    private func subscribeOnNewEvent() {
        eventTransceiver?.subscribe { [weak self] result in
            switch result {
            case .success(let model):
                _ = self?.subscriber?.receive(completion: .finished)
                _ = self?.subscriber?.receive(model)
            case .failure(let error):
                _ = self?.subscriber?.receive(completion: .failure(error))
            }
        }
    }

}
