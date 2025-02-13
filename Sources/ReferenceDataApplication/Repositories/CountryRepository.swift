//
//  CountryRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

package protocol CountryRepository {

    func fetchAll() async throws(FetchCountriesError) -> [Country]

    func fetch(byID id: Country.ID) async throws(FetchCountryError) -> Country

}
