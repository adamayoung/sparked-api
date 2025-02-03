//
//  CreateProfileRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol CreateBasicProfileRepository {

    func create(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile

}
