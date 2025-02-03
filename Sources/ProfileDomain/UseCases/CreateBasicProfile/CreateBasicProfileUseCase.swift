//
//  CreateBasicProfileUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol CreateBasicProfileUseCase {

    func execute(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile

}
