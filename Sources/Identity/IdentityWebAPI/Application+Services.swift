//
//  Application+Services.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/02/2025.
//

import Foundation
import IdentityApplication
import Vapor

extension Application {

    package struct IdentityServices {
        package struct Provider {
            let run: (Application) -> Void

            package init(_ run: @escaping (Application) -> Void) {
                self.run = run
            }
        }

        final class Storage: @unchecked Sendable {

            var makeTokenPayloadService: ((Application) -> any TokenPayloadService)?

            init() {}

        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var makeTokenPayloadService: any TokenPayloadService {
            guard let makeProvider = self.storage.makeTokenPayloadService else {
                fatalError(
                    "No TokenPayloadService configured. Configure with app.identityServices.use(...)"
                )
            }
            return makeProvider(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeService: @escaping (Application) -> any TokenPayloadService) {
            self.storage.makeTokenPayloadService = makeService
        }

        func initialize() {
            self.application.storage[Key.self] = .init()
        }

        private var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }

            guard let storage = application.storage[Key.self] else {
                fatalError("Unable to retrieve IdentityServices storage")
            }

            return storage
        }
    }

    package var identityServices: IdentityServices {
        .init(application: self)
    }

}
