//
//  CountryCacheDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol CountryCacheDataSource: Sendable {

    func fetchAll() async throws(CountryRepositoryError) -> [Country]?

    func setCountries(_ countries: [Country]) async throws(CountryRepositoryError)

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country?

    func setCountry(_ country: Country) async throws(CountryRepositoryError)

}
