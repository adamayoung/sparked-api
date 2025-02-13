//
//  FetchCountryUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package protocol FetchCountryUseCase {

    func execute(id: CountryDTO.ID) async throws(FetchCountryError) -> CountryDTO

}
