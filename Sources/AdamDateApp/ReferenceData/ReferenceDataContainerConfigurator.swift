//
//  ReferenceDataContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import ReferenceDataInfrastructure
import ReferenceDataPresentation
import Vapor

final class ReferenceDataContainerConfigurator: ContainerConfigurator {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func configure(in c: Container) {
        configureInfrastructure(in: c)
        configureApplication(in: c)
        configurePresentation(in: c)
    }

}

extension ReferenceDataContainerConfigurator {

    private func configureInfrastructure(in c: Container) {
        c.register(type: Database.self, name: DatabaseID.referenceData.string) { [database] _ in
            database
        }

        c.register(type: CountryRepository.self) { c in
            ReferenceDataInfrastructureFactory.makeCountryRepository(
                database: c.resolve(Database.self, name: DatabaseID.referenceData.string)
            )
        }

        c.register(type: GenderRepository.self) { c in
            ReferenceDataInfrastructureFactory.makeGenderRepository(
                database: c.resolve(Database.self, name: DatabaseID.referenceData.string)
            )
        }
    }

    private func configureApplication(in c: Container) {
        c.register(type: FetchCountriesUseCase.self) { c in
            ReferenceDataApplicationFactory.makeFetchCountriesUseCase(
                countryRepository: c.resolve(CountryRepository.self)
            )
        }

        c.register(type: FetchCountryUseCase.self) { c in
            ReferenceDataApplicationFactory.makeFetchCountryUseCase(
                countryRepository: c.resolve(CountryRepository.self)
            )
        }

        c.register(type: FetchGendersUseCase.self) { c in
            ReferenceDataApplicationFactory.makeFetchGendersUseCase(
                genderRepository: c.resolve(GenderRepository.self)
            )
        }

        c.register(type: FetchGenderUseCase.self) { c in
            ReferenceDataApplicationFactory.makeFetchGenderUseCase(
                genderRepository: c.resolve(GenderRepository.self)
            )
        }
    }

    private func configurePresentation(in c: Container) {
        c.register(type: RouteCollection.self, name: "CountryController") { c in
            ReferenceDataPresentationFactory.makeCountryController(
                fetchCountriesUseCase: { [c] in c.resolve(FetchCountriesUseCase.self) },
                fetchCountryUseCase: { [c] in c.resolve(FetchCountryUseCase.self) }
            )
        }

        c.register(type: RouteCollection.self, name: "GenderController") { c in
            ReferenceDataPresentationFactory.makeGenderController(
                fetchGendersUseCase: { [c] in c.resolve(FetchGendersUseCase.self) },
                fetchGenderUseCase: { [c] in c.resolve(FetchGenderUseCase.self) }
            )
        }
    }

}
