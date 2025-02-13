//
//  CountryRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol CountryRemoteDataSource {

    func fetchAll() async throws(FetchCountriesError) -> [Country]

    func fetch(byID id: Country.ID) async throws(FetchCountryError) -> Country

}
