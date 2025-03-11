//
//  DeleteProfilePhoto.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation
import ProfileDomain

final class DeleteProfilePhoto: DeleteProfilePhotoUseCase {

    private let repository: any ProfilePhotoRepository
    private let basicProfileRepository: any BasicProfileRepository
    private let imageRepository: any ImageRepository

    init(
        repository: some ProfilePhotoRepository,
        basicProfileRepository: some BasicProfileRepository,
        imageRepository: some ImageRepository
    ) {
        self.repository = repository
        self.basicProfileRepository = basicProfileRepository
        self.imageRepository = imageRepository
    }

    func execute(input: DeleteProfilePhotoInput) async throws(DeleteProfilePhotoError) {
        try await verifyBasicProfile(withID: input.profileID)
        let profilePhoto = try await profilePhoto(withID: input.photoID)

        try await deleteProfilePhotoAndImage(profilePhoto: profilePhoto)
        try await updateProfilePhotosOrder(forProfileID: input.profileID)
    }
}

extension DeleteProfilePhoto {

    private func verifyBasicProfile(
        withID id: UUID
    ) async throws(DeleteProfilePhotoError) {
        do {
            _ = try await basicProfileRepository.fetch(byID: id)
        } catch BasicProfileRepositoryError.notFound {
            throw .profileNotFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func profilePhoto(
        withID id: UUID
    ) async throws(DeleteProfilePhotoError) -> ProfilePhoto {
        let profilePhoto: ProfilePhoto
        do {
            profilePhoto = try await repository.fetch(byID: id)
        } catch ProfilePhotoRepositoryError.notFound {
            throw .profilePhotoNotFound(profilePhotoID: id)
        } catch let error {
            throw .unknown(error)
        }

        return profilePhoto
    }

    private func deleteProfilePhotoAndImage(
        profilePhoto: ProfilePhoto
    ) async throws(DeleteProfilePhotoError) {
        do {
            try await imageRepository.delete(filename: profilePhoto.filename)
        } catch let error {
            throw .unknown(error)
        }

        do {
            try await repository.delete(id: profilePhoto.id)
        } catch ProfilePhotoRepositoryError.notFound {
            throw .profilePhotoNotFound(profilePhotoID: profilePhoto.id)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func profilePhotos(
        forProfileID id: UUID
    ) async throws(DeleteProfilePhotoError) -> [ProfilePhoto] {
        let profilePhotos: [ProfilePhoto]
        do {
            profilePhotos = try await repository.fetchAll(forProfileID: id)
        } catch ProfilePhotoRepositoryError.notFound {
            throw .profileNotFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }

        return profilePhotos
    }

    private func updateProfilePhotosOrder(
        forProfileID profileID: UUID
    ) async throws(DeleteProfilePhotoError) {
        var profilePhotos = try await profilePhotos(forProfileID: profileID)
            .sorted { $0.index < $1.index }

        for index in 0..<profilePhotos.count {
            profilePhotos[index] = profilePhotos[index].withIndex(index)
        }

        do {
            try await repository.update(profilePhotos: profilePhotos)
        } catch let error {
            throw .unknown(error)
        }
    }

}
