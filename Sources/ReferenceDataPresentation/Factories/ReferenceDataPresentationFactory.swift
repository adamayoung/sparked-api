//
//  ReferenceDataPresentationFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import Vapor

package final class ReferenceDataPresentationFactory: Sendable {

    private init() {}

    package static func makeCountryController(
        fetchCountriesUseCase: @escaping @Sendable () -> any FetchCountriesUseCase,
        fetchCountryUseCase: @escaping @Sendable () -> any FetchCountryUseCase
    ) -> some RouteCollection {
        let dependencies = CountryController.Dependencies(
            fetchCountriesUseCase: fetchCountriesUseCase,
            fetchCountryUseCase: fetchCountryUseCase
        )

        return CountryController(dependencies: dependencies)
    }

    package static func makeGenderController(
        fetchGendersUseCase: @escaping @Sendable () -> any FetchGendersUseCase,
        fetchGenderUseCase: @escaping @Sendable () -> any FetchGenderUseCase
    ) -> some RouteCollection {
        let dependencies = GenderController.Dependencies(
            fetchGendersUseCase: fetchGendersUseCase,
            fetchGenderUseCase: fetchGenderUseCase
        )

        return GenderController(dependencies: dependencies)
    }

}
