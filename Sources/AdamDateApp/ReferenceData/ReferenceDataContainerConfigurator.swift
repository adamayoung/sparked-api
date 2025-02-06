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

        c.register(type: GenderRemoteDataSource.self) { c in
            GenderRemoteFluentDataSource(
                database: c.resolve(Database.self, name: DatabaseID.referenceData.string)
            )
        }

        c.register(type: CountryRemoteDataSource.self) { c in
            CountryRemoteFluentDataSource(
                database: c.resolve(Database.self, name: DatabaseID.referenceData.string)
            )
        }

        c.register(type: GenderRepository.self) { c in
            GenderDefaultRepository(
                remoteDataSource: c.resolve(GenderRemoteDataSource.self)
            )
        }

        c.register(type: CountryRepository.self) { c in
            CountryDefaultRepository(
                remoteDataSource: c.resolve(CountryRemoteDataSource.self)
            )
        }
    }

    private func configureApplication(in c: Container) {
        c.register(type: FetchGendersUseCase.self) { c in
            FetchGenders(repository: c.resolve(GenderRepository.self))
        }

        c.register(type: FetchCountriesUseCase.self) { c in
            FetchCountries(repository: c.resolve(CountryRepository.self))
        }
    }

    private func configurePresentation(in c: Container) {
        c.register(type: CountryController.self) { c in
            let dependencies = CountryController.Dependencies(
                fetchCountriesUseCase: { [c] in c.resolve(FetchCountriesUseCase.self) }
            )

            return CountryController(dependencies: dependencies)
        }

        c.register(type: GenderController.self) { c in
            let dependencies = GenderController.Dependencies(
                fetchGendersUseCase: { [c] in c.resolve(FetchGendersUseCase.self) }
            )

            return GenderController(dependencies: dependencies)
        }
    }

}
