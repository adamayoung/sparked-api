//
//  CountryDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class CountryDefaultRepository: CountryRepository {

    private let remoteDataSource: any CountryRemoteDataSource

    init(remoteDataSource: some CountryRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchAll() async throws(FetchCountriesError) -> [Country] {
        try await remoteDataSource.fetchAll()
    }

    func fetch(byID id: Country.ID) async throws(FetchCountryError) -> Country {
        try await remoteDataSource.fetch(byID: id)
    }

}
