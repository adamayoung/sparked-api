//
//  Request+UseCases.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/02/2025.
//

import Foundation
import IdentityApplication
import Vapor

extension Application {

    package struct IdentityUseCases {
        package struct Provider {
            let run: (Application) -> Void

            package init(_ run: @escaping (Application) -> Void) {
                self.run = run
            }
        }

        final class Storage: @unchecked Sendable {

            var makeFetchUserUseCase: ((Application) -> any FetchUserUseCase)?
            var makeRegisterUserUseCase: ((Application) -> any RegisterUserUseCase)?
            var makeAuthenticateUserUseCase: ((Application) -> any AuthenticateUserUseCase)?

            init() {}

        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var fetchUserUseCase: any FetchUserUseCase {
            guard let makeUseCase = self.storage.makeFetchUserUseCase else {
                fatalError(
                    "No FetchUserUseCase configured. Configure with app.identityUseCases.use(...)")
            }
            return makeUseCase(self.application)
        }

        var registerUserUseCase: any RegisterUserUseCase {
            guard let makeUseCase = self.storage.makeRegisterUserUseCase else {
                fatalError(
                    "No RegisterUserUseCase configured. Configure with app.identityUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var authenticateUserUseCase: any AuthenticateUserUseCase {
            guard let makeUseCase = self.storage.makeAuthenticateUserUseCase else {
                fatalError(
                    "No AuthenticateUserUseCase configured. Configure with app.identityUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchUserUseCase) {
            self.storage.makeFetchUserUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any RegisterUserUseCase) {
            self.storage.makeRegisterUserUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any AuthenticateUserUseCase) {
            self.storage.makeAuthenticateUserUseCase = makeUseCase
        }

        func initialize() {
            self.application.storage[Key.self] = .init()
        }

        private var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }

            guard let storage = application.storage[Key.self] else {
                fatalError("Unable to retrieve IdentityUseCases storage")
            }

            return storage
        }
    }

    package var identityUseCases: IdentityUseCases {
        .init(application: self)
    }

}

extension Request {

    var fetchUserUseCase: any FetchUserUseCase {
        application.identityUseCases.fetchUserUseCase
    }

    var registerUserUseCase: any RegisterUserUseCase {
        application.identityUseCases.registerUserUseCase
    }

    var authenticateUserUseCase: any AuthenticateUserUseCase {
        application.identityUseCases.authenticateUserUseCase
    }

}
