//
//  Application+UseCases.swift
//  AdamDateApp
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

            var makeRegisterUserUseCase: ((Application) -> RegisterUserUseCase)?

            init() {}

        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var registerUserUseCase: RegisterUserUseCase {
            guard let makeUseCase = self.storage.makeRegisterUserUseCase else {
                fatalError(
                    "No RegisterUserUseCase configured. Configure with app.commandUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeUseCase: @escaping (Application) -> RegisterUserUseCase) {
            self.storage.makeRegisterUserUseCase = makeUseCase
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
