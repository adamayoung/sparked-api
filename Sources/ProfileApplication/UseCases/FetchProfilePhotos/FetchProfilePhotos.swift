//
//  FetchProfilePhotos.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation
import ProfileDomain

final class FetchProfilePhotos: FetchProfilePhotosUseCase {

    private let repository: any ProfilePhotoRepository
    private let imageRepository: any ImageRepository

    init(
        repository: some ProfilePhotoRepository,
        imageRepository: some ImageRepository
    ) {
        self.repository = repository
        self.imageRepository = imageRepository
    }

    func execute(profileID: UUID) async throws(FetchProfilePhotosError) -> [ProfilePhotoDTO] {
        let profilePhotos: [ProfilePhoto]
        do {
            profilePhotos = try await repository.fetchAll(forProfileID: profileID)
        } catch ProfilePhotoRepositoryError.notFound {
            throw .notFoundForProfile(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        var results: [(ProfilePhoto, URL)] = []
        do {
            for profilePhoto in profilePhotos {
                let url = try await imageRepository.url(for: profilePhoto.filename)
                results.append((profilePhoto, url))
            }
        } catch let error {
            throw .unknown(error)
        }

        let profilePhotoDTOs =
            results
            .map { (profilePhoto, url) in
                ProfilePhotoDTOMapper.map(from: profilePhoto, photoURL: url)
            }
            .sorted { $0.index < $1.index }

        return profilePhotoDTOs
    }

}
