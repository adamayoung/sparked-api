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
        forProfileID profileID: BasicProfile.ID
    ) async throws(ProfilePhotoRepositoryError) -> [ProfilePhoto]

    func fetch(byID id: ProfilePhoto.ID) async throws(ProfilePhotoRepositoryError) -> ProfilePhoto

    func update(profilePhotos: [ProfilePhoto]) async throws(ProfilePhotoRepositoryError)

    func delete(id: ProfilePhoto.ID) async throws(ProfilePhotoRepositoryError)

}
