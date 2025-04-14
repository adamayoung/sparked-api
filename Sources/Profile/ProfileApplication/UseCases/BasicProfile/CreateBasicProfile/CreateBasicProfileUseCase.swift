//
//  CreateBasicProfileUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol CreateBasicProfileUseCase {

    func execute(
        input: CreateBasicProfileInput,
        userContext: some UserContext
    ) async throws(CreateBasicProfileError) -> BasicProfileDTO

}
