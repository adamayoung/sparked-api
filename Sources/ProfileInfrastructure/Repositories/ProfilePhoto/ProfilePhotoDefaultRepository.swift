//
//  ProfilePhotoDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 21/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class ProfilePhotoDefaultRepository: ProfilePhotoRepository {

    private let remoteDataSource: any ProfilePhotoRemoteDataSource

    init(remoteDataSource: some ProfilePhotoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ profilePhoto: ProfilePhoto) async throws(ProfilePhotoRepositoryError) {
        try await remoteDataSource.create(profilePhoto)
    }

    func fetchAll(
        forProfileID profileID: UUID
    ) async throws(ProfilePhotoRepositoryError) -> [ProfilePhoto] {
        try await remoteDataSource.fetchAll(forProfileID: profileID)
    }

    func fetch(byID id: UUID) async throws(ProfilePhotoRepositoryError) -> ProfilePhoto {
        try await remoteDataSource.fetch(byID: id)
    }

}
