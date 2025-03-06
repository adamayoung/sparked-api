//
//  ProfilePhotoRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 21/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

package protocol ProfilePhotoRemoteDataSource {

    func create(_ profilePhoto: ProfilePhoto) async throws(ProfilePhotoRepositoryError)

    func fetchAll(
        forProfileID profileID: UUID
    ) async throws(ProfilePhotoRepositoryError) -> [ProfilePhoto]

    func fetch(byID id: UUID) async throws(ProfilePhotoRepositoryError) -> ProfilePhoto

}
