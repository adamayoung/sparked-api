//
//  Application+Services.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Vapor

extension Application {

    package struct HealthServices {
        package struct Provider {
            let run: (Application) -> Void

            package init(_ run: @escaping (Application) -> Void) {
                self.run = run
            }
        }

        final class Storage: @unchecked Sendable {

            var makeHealthService: ((Application) -> HealthService)?

            init() {}

        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var makeHealthService: HealthService {
            guard let makeProvider = self.storage.makeHealthService else {
                fatalError(
                    "No HealthServices configured. Configure with app.healthServices.use(...)"
                )
            }
            return makeProvider(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeService: @escaping (Application) -> HealthService) {
            self.storage.makeHealthService = makeService
        }

        func initialize() {
            self.application.storage[Key.self] = .init()
        }

        private var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }

            guard let storage = application.storage[Key.self] else {
                fatalError("Unable to retrieve HealthServices storage")
            }

            return storage
        }
    }

    package var healthServices: HealthServices {
        .init(application: self)
    }

}

extension Request {

    var healthService: HealthService {
        application.healthServices.makeHealthService
    }

}
