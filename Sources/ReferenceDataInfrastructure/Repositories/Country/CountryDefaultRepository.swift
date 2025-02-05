//
//  CountryDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

package final class CountryDefaultRepository: CountryRepository {

    private let remoteDataSource: any CountryRemoteDataSource

    package init(remoteDataSource: some CountryRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    package func countries() async throws(FetchCountriesError) -> [Country] {
        try await remoteDataSource.countries()
    }

}
