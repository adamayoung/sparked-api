//
//  FetchCountriesUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol FetchCountriesUseCase {

    func execute() async throws(FetchCountriesError) -> [CountryDTO]

}
