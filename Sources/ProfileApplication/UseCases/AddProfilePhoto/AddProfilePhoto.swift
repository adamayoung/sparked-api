//
//  AddProfilePhoto.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileDomain

final class AddProfilePhoto: AddProfilePhotoUseCase {

    private static var maxPhotoCount: Int {
        ProfilePhotoConfiguration.maxCount
    }

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

    func execute(
        input: AddProfilePhotoInput,
        userContext: some UserContext
    ) async throws(AddProfilePhotoError) -> ProfilePhotoDTO {
        let basicProfile = try await basicProfile(withID: input.profileID)
        guard userContext.canWrite(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        let nextPhotoIndex = try await nextPhotoIndex(forProfileID: basicProfile.id)

        let photoID = UUID()
        let filename = "\(basicProfile.id)_\(photoID).\(input.photoType)"
        let photoURL = try await addPhoto(input.photoData, filename: filename)

        let profilePhoto = ProfilePhoto(
            profileID: basicProfile.id,
            index: nextPhotoIndex,
            filename: filename,
            ownerID: basicProfile.id
        )

        try await create(profilePhoto)

        let profilePhotoDTO = ProfilePhotoDTOMapper.map(from: profilePhoto, photoURL: photoURL)

        return profilePhotoDTO
    }

}

extension AddProfilePhoto {

    private func basicProfile(withID id: UUID) async throws(AddProfilePhotoError) -> BasicProfile {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await basicProfileRepository.fetch(byID: id)
        } catch BasicProfileRepositoryError.notFound {
            throw .profileNotFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }

        return basicProfile
    }

    private func nextPhotoIndex(forProfileID id: UUID) async throws(AddProfilePhotoError) -> Int {
        let profilePhotosCount: Int
        do {
            profilePhotosCount = try await repository.fetchAll(forProfileID: id).count
        } catch let error {
            throw .unknown(error)
        }

        guard profilePhotosCount < Self.maxPhotoCount else {
            throw .tooManyPhotos(maxCount: Self.maxPhotoCount)
        }

        return profilePhotosCount
    }

    private func addPhoto(
        _ photoData: Data,
        filename: String
    ) async throws(AddProfilePhotoError) -> URL {
        let photoURL: URL
        do {
            try await imageRepository.create(photoData, filename: filename)
            photoURL = try await imageRepository.url(for: filename)
        } catch let error {
            throw .unknown(error)
        }

        return photoURL
    }

    private func create(_ profilePhoto: ProfilePhoto) async throws(AddProfilePhotoError) {
        do {
            try await repository.create(profilePhoto)
        } catch let error {
            throw .unknown(error)
        }
    }

}
