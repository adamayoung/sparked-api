//
//  ClientStub.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import NIOCore
import Vapor

final class ClientStub: Client, @unchecked Sendable {

    let eventLoop: any EventLoop
    let logger: Logger?

    var response: ClientResponse?
    private(set) var sendWasCalled = false
    private(set) var lastSendRequest: ClientRequest?

    init(eventLoop: some EventLoop) {
        self.logger = nil
        self.eventLoop = eventLoop
    }

    func send(_ request: ClientRequest) -> EventLoopFuture<ClientResponse> {
        self.sendWasCalled = true
        self.lastSendRequest = request

        guard let response else {
            return eventLoop.makeFailedFuture(Abort(.internalServerError))
        }

        return eventLoop.makeSucceededFuture(response)
    }

    func delegating(to eventLoop: any EventLoop) -> any Client {
        self
    }

}
