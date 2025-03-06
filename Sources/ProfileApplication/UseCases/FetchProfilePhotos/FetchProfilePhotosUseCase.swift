//
//  FetchProfilePhotosUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation

package protocol FetchProfilePhotosUseCase {

    func execute(profileID: UUID) async throws(FetchProfilePhotosError) -> [ProfilePhotoDTO]

}
