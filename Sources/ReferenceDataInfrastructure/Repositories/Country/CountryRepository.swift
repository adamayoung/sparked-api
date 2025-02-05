//
//  CountryRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

package protocol CountryRepository: FetchCountriesRepository {

    func countries() async throws(FetchCountriesError) -> [Country]

}
