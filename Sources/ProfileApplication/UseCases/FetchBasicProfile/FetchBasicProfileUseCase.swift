//
//  FetchBasicProfileUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol FetchBasicProfileUseCase {

    func execute(
        id: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO

}
