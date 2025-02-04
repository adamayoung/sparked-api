//
//  DefaultReferenceDataContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain
import ReferenceDataInfrastructure

final class DefaultReferenceDataContainerConfigurator: ContainerConfigurator {

    private let c: Container

    init(container: Container) {
        self.c = container
    }

    func configure() {
        configureRepositories()
        configureUseCases()
    }

}

extension DefaultReferenceDataContainerConfigurator {

    private func configureRepositories() {
        c.register(type: GenderRepository.self) { _ in
            GenderStaticRepository()
        }

        c.register(type: CountryRepository.self) { _ in
            CountryStaticRepository()
        }
    }

    private func configureUseCases() {
        c.register(type: FetchGendersUseCase.self) { c in
            FetchGenders(repository: c.resolve(GenderRepository.self))
        }

        c.register(type: FetchCountriesUseCase.self) { c in
            FetchCountries(repository: c.resolve(CountryRepository.self))
        }
    }

}
