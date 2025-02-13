//
//  IdentityPresentationFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import IdentityApplication
import Vapor

package final class IdentityPresentationFactory: Sendable {

    private init() {}

    package static func makeMeController(
        fetchUserUseCase: @escaping @Sendable () -> any FetchUserUseCase
    ) -> some RouteCollection {
        let dependencies = MeController.Dependencies(
            fetchUserUseCase: fetchUserUseCase
        )

        return MeController(dependencies: dependencies)
    }

    package static func makeRegisterController(
        registerUserUseCase: @escaping @Sendable () -> any RegisterUserUseCase
    ) -> some RouteCollection {
        let dependencies = RegisterController.Dependencies(
            registerUserUseCase: registerUserUseCase
        )

        return RegisterController(dependencies: dependencies)
    }

    package static func makeTokenController(
        authenticateUserUseCase: @escaping @Sendable () -> any AuthenticateUserUseCase,
        tokenPayloadProvider: @escaping @Sendable () -> any TokenPayloadProvider
    ) -> some RouteCollection {
        let dependencies = TokenController.Dependencies(
            authenticateUserUseCase: authenticateUserUseCase,
            tokenPayloadProvider: tokenPayloadProvider
        )

        return TokenController(dependencies: dependencies)
    }

}
