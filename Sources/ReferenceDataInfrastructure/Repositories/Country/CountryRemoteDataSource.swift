//
//  CountryRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

package protocol CountryRemoteDataSource {

    func countries() async throws(FetchCountriesError) -> [Country]

}
