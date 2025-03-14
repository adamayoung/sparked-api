//
//  FetchCountryUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package protocol FetchCountryUseCase: Sendable {

    func execute(id: CountryDTO.ID) async throws(FetchCountryError) -> CountryDTO

}
