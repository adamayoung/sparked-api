//
//  FetchProfilePhoto.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation
import ProfileDomain

final class FetchProfilePhoto: FetchProfilePhotoUseCase {

    private let repository: any ProfilePhotoRepository
    private let imageRepository: any ImageRepository

    init(
        repository: some ProfilePhotoRepository,
        imageRepository: some ImageRepository
    ) {
        self.repository = repository
        self.imageRepository = imageRepository
    }

    func execute(
        id: UUID,
        userContext: some UserContext
    ) async throws(FetchProfilePhotoError) -> ProfilePhotoDTO {
        let profilePhoto = try await profilePhoto(byID: id)
        guard userContext.canRead(ownerID: profilePhoto.ownerID) else {
            throw .unauthorized
        }

        let url = try await url(for: profilePhoto)

        let profilePhotoDTO = ProfilePhotoDTOMapper.map(from: profilePhoto, photoURL: url)

        return profilePhotoDTO
    }

}

extension FetchProfilePhoto {

    private func profilePhoto(
        byID id: ProfilePhoto.ID
    ) async throws(FetchProfilePhotoError) -> ProfilePhoto {
        let profilePhoto: ProfilePhoto
        do {
            profilePhoto = try await repository.fetch(byID: id)
        } catch ProfilePhotoRepositoryError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        return profilePhoto
    }

    private func url(for profilePhoto: ProfilePhoto) async throws(FetchProfilePhotoError) -> URL {
        let url: URL
        do {
            url = try await imageRepository.url(for: profilePhoto.filename)
        } catch let error {
            throw .unknown(error)
        }

        return url
    }

}
