//
//  CountryRemoteFluentDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

package final class CountryRemoteFluentDataSource: CountryRemoteDataSource {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    package func countries() async throws(FetchCountriesError) -> [Country] {
        let countryModels: [CountryModel]
        do {
            countryModels = try await CountryModel.query(on: database).all()
        } catch let error {
            throw .unknown(error)
        }

        let countries: [Country]
        do {
            countries = try countryModels.map(CountryMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return countries
    }

}
