//
//  IdentityWebAPIFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/02/2025.
//

import Vapor

package final class IdentityWebAPIFactory: Sendable {

    private init() {}

    package static func makeMeController() -> some RouteCollection {
        MeController()
    }

    package static func makeRegisterController() -> some RouteCollection {
        RegisterController()
    }

    package static func makeTokenController() -> some RouteCollection {
        TokenController()
    }

}
