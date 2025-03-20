//
//  ChangeProfilePhotoOrder.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation
import ProfileDomain

final class ChangeProfilePhotoOrder: ChangeProfilePhotoOrderUseCase {

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
        input: ChangeProfilePhotoOrderInput,
        userContext: some UserContext
    ) async throws(ChangeProfilePhotoOrderError) -> ProfilePhotoDTO {
        let basicProfile = try await basicProfile(withID: input.profileID)
        guard userContext.canWrite(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        let profilePhotos = try await profilePhotos(forProfileID: basicProfile.id)
            .sorted { $0.index < $1.index }

        guard
            let profilePhotoToUpdate = profilePhotos.first(
                where: { $0.id == input.photoID }
            )
        else {
            throw .profilePhotoNotFound(profilePhotoID: input.profileID)
        }

        guard profilePhotoToUpdate.index != input.newIndex else {
            let profilePhotoDTO = try await mapToDTO(profilePhotoToUpdate)
            return profilePhotoDTO
        }

        let maxIndex = profilePhotos.count - 1
        guard (0...maxIndex).contains(input.newIndex) else {
            throw .invalidIndex(index: input.newIndex, maxIndex: maxIndex)
        }

        let updatedProfilePhotos = updatedProfilePhotos(
            profilePhotos,
            profilePhotoID: input.photoID,
            newIndex: input.newIndex
        )

        do {
            try await repository.update(profilePhotos: updatedProfilePhotos)
        } catch let error {
            throw .unknown(error)
        }

        guard
            let updatedProfilePhoto = updatedProfilePhotos.first(
                where: { $0.id == input.photoID }
            )
        else {
            throw .profilePhotoNotFound(profilePhotoID: input.photoID)
        }

        let profilePhotoDTO = try await mapToDTO(updatedProfilePhoto)
        return profilePhotoDTO
    }

}

extension ChangeProfilePhotoOrder {

    private func basicProfile(
        withID id: UUID
    ) async throws(ChangeProfilePhotoOrderError) -> BasicProfile {
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

    private func profilePhotos(
        forProfileID id: UUID
    ) async throws(ChangeProfilePhotoOrderError) -> [ProfilePhoto] {
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

    private func updatedProfilePhotos(
        _ profilePhotos: [ProfilePhoto],
        profilePhotoID: UUID,
        newIndex: Int
    ) -> [ProfilePhoto] {
        var updatedProfilePhotos: [ProfilePhoto] = []
        for profilePhoto in profilePhotos {
            if profilePhoto.id == profilePhotoID {
                updatedProfilePhotos.append(profilePhoto.withIndex(newIndex))
                continue
            }

            if profilePhoto.index >= newIndex {
                updatedProfilePhotos.append(profilePhoto.withIndex(profilePhoto.index + 1))
                continue
            }

            updatedProfilePhotos.append(profilePhoto)
        }

        return updatedProfilePhotos
    }

    private func mapToDTO(
        _ profilePhoto: ProfilePhoto
    ) async throws(ChangeProfilePhotoOrderError) -> ProfilePhotoDTO {
        let photoURL: URL
        do {
            photoURL = try await imageRepository.url(for: profilePhoto.filename)
        } catch let error {
            throw .unknown(error)
        }

        let profilePhotoDTO = ProfilePhotoDTOMapper.map(from: profilePhoto, photoURL: photoURL)

        return profilePhotoDTO
    }

}
