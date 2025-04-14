//
//  CountryRemoteFluentDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class CountryRemoteFluentDataSource: CountryRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func fetchAll() async throws(CountryRepositoryError) -> [Country] {
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

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country {
        let countryModel: CountryModel?
        do {
            countryModel = try await CountryModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let countryModel else {
            throw .notFound
        }

        let country: Country
        do {
            country = try CountryMapper.map(from: countryModel)
        } catch let error {
            throw .unknown(error)
        }

        return country
    }

}
