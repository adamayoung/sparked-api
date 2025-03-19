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

    package struct ReferenceDataWebAPIUseCases {
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

            var makeFetchInterestGroupsUseCase: ((Application) -> FetchInterestGroupsUseCase)?
            var makeFetchInterestGroupUseCase: ((Application) -> FetchInterestGroupUseCase)?

            var makeFetchInterestsUseCase: ((Application) -> FetchInterestsUseCase)?
            var makeFetchInterestUseCase: ((Application) -> FetchInterestUseCase)?

            var makeFetchStarSignsUseCase: ((Application) -> FetchStarSignsUseCase)?
            var makeFetchStarSignUseCase: ((Application) -> FetchStarSignUseCase)?

            var makeFetchEducationLevelsUseCase: ((Application) -> FetchEducationLevelsUseCase)?
            var makeFetchEducationLevelUseCase: ((Application) -> FetchEducationLevelUseCase)?

            init() {}
        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var fetchCountriesUseCase: any FetchCountriesUseCase {
            guard let makeUseCase = self.storage.makeFetchCountriesUseCase else {
                fatalError(
                    "No FetchCountriesUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchCountryUseCase: any FetchCountryUseCase {
            guard let makeUseCase = self.storage.makeFetchCountryUseCase else {
                fatalError(
                    "No FetchCountryUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchGendersUseCase: any FetchGendersUseCase {
            guard let makeUseCase = self.storage.makeFetchGendersUseCase else {
                fatalError(
                    "No FetchGendersUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchGenderUseCase: any FetchGenderUseCase {
            guard let makeUseCase = self.storage.makeFetchGenderUseCase else {
                fatalError(
                    "No FetchGenderUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchInterestGroupsUseCase: any FetchInterestGroupsUseCase {
            guard let makeUseCase = self.storage.makeFetchInterestGroupsUseCase else {
                fatalError(
                    "No FetchInterestGroupsUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchInterestGroupUseCase: any FetchInterestGroupUseCase {
            guard let makeUseCase = self.storage.makeFetchInterestGroupUseCase else {
                fatalError(
                    "No FetchInterestGroupUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchInterestsUseCase: any FetchInterestsUseCase {
            guard let makeUseCase = self.storage.makeFetchInterestsUseCase else {
                fatalError(
                    "No FetchInterestsUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchInterestUseCase: any FetchInterestUseCase {
            guard let makeUseCase = self.storage.makeFetchInterestUseCase else {
                fatalError(
                    "No FetchInterestUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchStarSignsUseCase: any FetchStarSignsUseCase {
            guard let makeUseCase = self.storage.makeFetchStarSignsUseCase else {
                fatalError(
                    "No FetchStarSignsUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchStarSignUseCase: any FetchStarSignUseCase {
            guard let makeUseCase = self.storage.makeFetchStarSignUseCase else {
                fatalError(
                    "No FetchStarSignUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchEducationLevelsUseCase: any FetchEducationLevelsUseCase {
            guard let makeUseCase = self.storage.makeFetchEducationLevelsUseCase else {
                fatalError(
                    "No FetchEducationLevelsUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchEducationLevelUseCase: any FetchEducationLevelUseCase {
            guard let makeUseCase = self.storage.makeFetchEducationLevelUseCase else {
                fatalError(
                    "No FetchEducationLevelUseCase configured. Configure with app.referenceDataWebAPIUseCases.use(...)"
                )
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

        package func use(_ makeUseCase: @escaping (Application) -> FetchInterestGroupsUseCase) {
            self.storage.makeFetchInterestGroupsUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchInterestGroupUseCase) {
            self.storage.makeFetchInterestGroupUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchInterestsUseCase) {
            self.storage.makeFetchInterestsUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchInterestUseCase) {
            self.storage.makeFetchInterestUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchStarSignsUseCase) {
            self.storage.makeFetchStarSignsUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchStarSignUseCase) {
            self.storage.makeFetchStarSignUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchEducationLevelsUseCase) {
            self.storage.makeFetchEducationLevelsUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchEducationLevelUseCase) {
            self.storage.makeFetchEducationLevelUseCase = makeUseCase
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

    package var referenceDataWebAPIUseCases: ReferenceDataWebAPIUseCases {
        .init(application: self)
    }

}

extension Request {

    var fetchCountriesUseCase: FetchCountriesUseCase {
        application.referenceDataWebAPIUseCases.fetchCountriesUseCase
    }

    var fetchCountryUseCase: FetchCountryUseCase {
        application.referenceDataWebAPIUseCases.fetchCountryUseCase
    }

    var fetchGendersUseCase: FetchGendersUseCase {
        application.referenceDataWebAPIUseCases.fetchGendersUseCase
    }

    var fetchGenderUseCase: FetchGenderUseCase {
        application.referenceDataWebAPIUseCases.fetchGenderUseCase
    }

    var fetchInterestGroupsUseCase: FetchInterestGroupsUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestGroupsUseCase
    }

    var fetchInterestGroupUseCase: FetchInterestGroupUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestGroupUseCase
    }

    var fetchInterestsUseCase: FetchInterestsUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestsUseCase
    }

    var fetchInterestUseCase: FetchInterestUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestUseCase
    }

    var fetchStarSignsUseCase: FetchStarSignsUseCase {
        application.referenceDataWebAPIUseCases.fetchStarSignsUseCase
    }

    var fetchStarSignUseCase: FetchStarSignUseCase {
        application.referenceDataWebAPIUseCases.fetchStarSignUseCase
    }

    var fetchEducationLevelsUseCase: FetchEducationLevelsUseCase {
        application.referenceDataWebAPIUseCases.fetchEducationLevelsUseCase
    }

    var fetchEducationLevelUseCase: FetchEducationLevelUseCase {
        application.referenceDataWebAPIUseCases.fetchEducationLevelUseCase
    }

}
