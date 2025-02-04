//
//  FetchCountriesRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol FetchCountriesRepository {

    func countries() async throws(FetchCountriesError) -> [Country.ID: Country]

}
