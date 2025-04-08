//
//  Application+UseCases.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation
import IdentityApplication
import Vapor

extension Application {

    package struct CommandUseCases {
        package struct Provider {
            let run: (Application) -> Void

            package init(_ run: @escaping (Application) -> Void) {
                self.run = run
            }
        }

        final class Storage: @unchecked Sendable {

            var makeRegisterUserUseCase: ((Application) -> any RegisterUserUseCase)?
            var makeFetchRolesUseCase: ((Application) -> any FetchRolesUseCase)?

            init() {}

        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var registerUserUseCase: any RegisterUserUseCase {
            guard let makeUseCase = self.storage.makeRegisterUserUseCase else {
                fatalError(
                    "No RegisterUserUseCase configured. Configure with app.commandUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchRolesUseCase: any FetchRolesUseCase {
            guard let makeUseCase = self.storage.makeFetchRolesUseCase else {
                fatalError(
                    "No FetchRolesUseCase configured. Configure with app.commandUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeUseCase: @escaping (Application) -> any RegisterUserUseCase) {
            self.storage.makeRegisterUserUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchRolesUseCase) {
            self.storage.makeFetchRolesUseCase = makeUseCase
        }

        func initialize() {
            self.application.storage[Key.self] = .init()
        }

        private var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }

            guard let storage = application.storage[Key.self] else {
                fatalError("Unable to retrieve CommandUseCases storage")
            }

            return storage
        }
    }

    package var commandUseCases: CommandUseCases {
        .init(application: self)
    }

}
