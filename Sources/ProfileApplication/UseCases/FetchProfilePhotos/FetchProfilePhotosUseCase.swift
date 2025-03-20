//
//  FetchProfilePhotosUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation

package protocol FetchProfilePhotosUseCase {

    func execute(
        profileID: UUID,
        userContext: some UserContext
    ) async throws(FetchProfilePhotosError) -> [ProfilePhotoDTO]

}
