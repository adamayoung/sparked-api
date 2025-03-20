//
//  FetchProfilePhotos.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation
import ProfileDomain

final class FetchProfilePhotos: FetchProfilePhotosUseCase {

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
        profileID: UUID,
        userContext: some UserContext
    ) async throws(FetchProfilePhotosError) -> [ProfilePhotoDTO] {
        let basicProfile = try await basicProfile(byID: profileID)
        guard userContext.canRead(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        let profilePhotos = try await profilePhotos(forProfileID: profileID)
        let results = try await profilePhotosWithURLs(profilePhotos)

        let profilePhotoDTOs = results.map(ProfilePhotoDTOMapper.map)
            .sorted { $0.index < $1.index }

        return profilePhotoDTOs
    }

}

extension FetchProfilePhotos {

    private func basicProfile(
        byID profileID: BasicProfile.ID
    ) async throws(FetchProfilePhotosError) -> BasicProfile {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await basicProfileRepository.fetch(byID: profileID)
        } catch BasicProfileRepositoryError.notFound {
            throw .profileNotFound(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        return basicProfile
    }

    private func profilePhotos(
        forProfileID profileID: BasicProfile.ID
    ) async throws(FetchProfilePhotosError) -> [ProfilePhoto] {
        let profilePhotos: [ProfilePhoto]
        do {
            profilePhotos = try await repository.fetchAll(forProfileID: profileID)
        } catch ProfilePhotoRepositoryError.notFound {
            throw .profileNotFound(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        return profilePhotos
    }

    private func profilePhotosWithURLs(
        _ profilePhotos: [ProfilePhoto]
    ) async throws(FetchProfilePhotosError) -> [(ProfilePhoto, URL)] {
        var results: [(ProfilePhoto, URL)] = []
        do {
            for profilePhoto in profilePhotos {
                let url = try await imageRepository.url(for: profilePhoto.filename)
                results.append((profilePhoto, url))
            }
        } catch let error {
            throw .unknown(error)
        }

        return results
    }

}
