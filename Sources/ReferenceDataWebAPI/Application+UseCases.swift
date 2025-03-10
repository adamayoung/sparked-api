//
//  Request+UseCases.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import Vapor

extension Application {

    package struct ReferenceDataUseCases {
        package struct Provider {
            let run: (Application) -> Void

            package init(_ run: @escaping (Application) -> Void) {
                self.run = run
            }
        }

        final class Storage: @unchecked Sendable {

            var makeFetchCountriesUseCase: ((Application) -> FetchCountriesUseCase)?
            var makeFetchCountryUseCase: ((Application) -> FetchCountryUseCase)?

            var makeFetchGendersUseCase: ((Application) -> FetchGendersUseCase)?
            var makeFetchGenderUseCase: ((Application) -> FetchGenderUseCase)?

            init() {}
        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var fetchCountriesUseCase: any FetchCountriesUseCase {
            guard let makeUseCase = self.storage.makeFetchCountriesUseCase else {
                fatalError(
                    "No FetchCountriesUseCase configured. Configure with app.useCases.use(...)")
            }
            return makeUseCase(self.application)
        }

        var fetchCountryUseCase: any FetchCountryUseCase {
            guard let makeUseCase = self.storage.makeFetchCountryUseCase else {
                fatalError(
                    "No FetchCountryUseCase configured. Configure with app.useCases.use(...)")
            }
            return makeUseCase(self.application)
        }

        var fetchGendersUseCase: any FetchGendersUseCase {
            guard let makeUseCase = self.storage.makeFetchGendersUseCase else {
                fatalError(
                    "No FetchGendersUseCase configured. Configure with app.useCases.use(...)")
            }
            return makeUseCase(self.application)
        }

        var fetchGenderUseCase: any FetchGenderUseCase {
            guard let makeUseCase = self.storage.makeFetchGenderUseCase else {
                fatalError("No FetchGenderUseCase configured. Configure with app.useCases.use(...)")
            }
            return makeUseCase(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchCountriesUseCase) {
            self.storage.makeFetchCountriesUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchCountryUseCase) {
            self.storage.makeFetchCountryUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchGendersUseCase) {
            self.storage.makeFetchGendersUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchGenderUseCase) {
            self.storage.makeFetchGenderUseCase = makeUseCase
        }

        func initialize() {
            self.application.storage[Key.self] = .init()
        }

        private var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }

            guard let storage = application.storage[Key.self] else {
                fatalError("Unable to retrieve ReferenceDataUseCases storage")
            }

            return storage
        }
    }

    package var referenceDataUseCases: ReferenceDataUseCases {
        .init(application: self)
    }

}

extension Request {

    var fetchCountriesUseCase: FetchCountriesUseCase {
        application.referenceDataUseCases.fetchCountriesUseCase
    }

    var fetchCountryUseCase: FetchCountryUseCase {
        application.referenceDataUseCases.fetchCountryUseCase
    }

    var fetchGendersUseCase: FetchGendersUseCase {
        application.referenceDataUseCases.fetchGendersUseCase
    }

    var fetchGenderUseCase: FetchGenderUseCase {
        application.referenceDataUseCases.fetchGenderUseCase
    }

}
