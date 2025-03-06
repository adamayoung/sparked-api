//
//  AddProfilePhoto.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileDomain

final class AddProfilePhoto: AddProfilePhotoUseCase {

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

    func execute(input: AddProfilePhotoInput) async throws(AddProfilePhotoError) -> ProfilePhotoDTO
    {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await basicProfileRepository.fetch(byID: input.profileID)
        } catch BasicProfileRepositoryError.notFound {
            throw .profileNotFound(profileID: input.profileID)
        } catch let error {
            throw .unknown(error)
        }

        let photoID = UUID()
        let filename = "\(basicProfile.id)_\(photoID).\(input.photoType)"

        let photoURL: URL
        do {
            try await imageRepository.create(input.photoData, filename: filename)
            photoURL = try await imageRepository.url(for: filename)
        } catch let error {
            throw .unknown(error)
        }

        let profilePhoto = ProfilePhoto(
            userID: basicProfile.userID,
            profileID: basicProfile.id,
            index: 0,
            filename: filename
        )

        do {
            try await repository.create(profilePhoto)
        } catch let error {
            throw .unknown(error)
        }

        let profilePhotoDTO = ProfilePhotoDTOMapper.map(from: profilePhoto, photoURL: photoURL)

        return profilePhotoDTO
    }

}
