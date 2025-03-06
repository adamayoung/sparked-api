//
//  ProfileRemoteFluentDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Fluent
import Foundation
import ProfileApplication
import ProfileDomain

final class ProfilePhotoRemoteFluentDataSource: ProfilePhotoRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func create(_ profilePhoto: ProfilePhoto) async throws(ProfilePhotoRepositoryError) {
        let profilePhotoModel = ProfilePhotoModelMapper.map(from: profilePhoto)

        do {
            try await profilePhotoModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    func fetchAll(forProfileID profileID: UUID) async throws(ProfilePhotoRepositoryError) -> [ProfilePhoto] {
        let profilePhotoModels: [ProfilePhotoModel]
        do {
            profilePhotoModels = try await ProfilePhotoModel.query(on: database)
                .filter(\.$profileID == profileID)
                .all()
        } catch let error {
            throw .unknown(error)
        }

        guard !profilePhotoModels.isEmpty else {
            throw .notFound
        }

        let profilePhotos: [ProfilePhoto]
        do {
            profilePhotos = try profilePhotoModels.map(ProfilePhotoMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return profilePhotos
    }

    func fetch(byID id: UUID) async throws(ProfilePhotoRepositoryError) -> ProfilePhoto {
        let profilePhotoModel: ProfilePhotoModel?
        do {
            profilePhotoModel = try await ProfilePhotoModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let profilePhotoModel else {
            throw .notFound
        }

        let profilePhoto: ProfilePhoto
        do {
            profilePhoto = try ProfilePhotoMapper.map(from: profilePhotoModel)
        } catch let error {
            throw .unknown(error)
        }

        return profilePhoto
    }

}
