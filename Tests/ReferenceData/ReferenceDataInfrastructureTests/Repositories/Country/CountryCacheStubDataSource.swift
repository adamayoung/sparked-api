//
//  CountryCacheStubDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

@testable import ReferenceDataInfrastructure

final class CountryCacheStubDataSource: CountryCacheDataSource {

    init() {}

    func fetchAll() async throws(CountryRepositoryError) -> [Country]? {
        nil
    }

    func setCountries(_ countries: [Country]) async throws(CountryRepositoryError) {
    }

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country? {
        nil
    }

    func setCountry(_ country: Country) async throws(CountryRepositoryError) {
    }

}
