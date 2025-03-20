//
//  FetchProfilePhotoUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation

package protocol FetchProfilePhotoUseCase {

    func execute(
        id: UUID,
        userContext: some UserContext
    ) async throws(FetchProfilePhotoError) -> ProfilePhotoDTO

}
