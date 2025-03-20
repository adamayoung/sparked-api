//
//  ProfileInterestRemoteFluentDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Fluent
import Foundation
import ProfileApplication
import ProfileDomain

final class ProfileInterestRemoteFluentDataSource: ProfileInterestRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func create(_ profileInterest: ProfileInterest) async throws(ProfileInterestRepositoryError) {
        let profileInterestModel = ProfileInterestModelMapper.map(from: profileInterest)

        do {
            try await profileInterestModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    func fetchAll(
        forProfileID profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> [ProfileInterest] {
        let profileInterestModels: [ProfileInterestModel]
        do {
            profileInterestModels = try await ProfileInterestModel.query(on: database)
                .filter(\.$profileID == profileID)
                .all()
        } catch let error {
            throw .unknown(error)
        }

        let profileInterests: [ProfileInterest]
        do {
            profileInterests = try profileInterestModels.map(ProfileInterestMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return profileInterests
    }

    func fetch(
        byID id: ProfileInterest.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest {
        let profileInterestModel: ProfileInterestModel?
        do {
            profileInterestModel = try await ProfileInterestModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let profileInterestModel else {
            throw .notFound
        }

        let profileInterest: ProfileInterest
        do {
            profileInterest = try ProfileInterestMapper.map(from: profileInterestModel)
        } catch let error {
            throw .unknown(error)
        }

        return profileInterest
    }

    func fetch(
        byInterestID interestID: Interest.ID,
        for profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest {
        let profileInterestModel: ProfileInterestModel?
        do {
            profileInterestModel = try await ProfileInterestModel.query(on: database)
                .filter(\.$interestID == interestID)
                .filter(\.$profileID == profileID)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let profileInterestModel else {
            throw .notFound
        }

        let profileInterest: ProfileInterest
        do {
            profileInterest = try ProfileInterestMapper.map(from: profileInterestModel)
        } catch let error {
            throw .unknown(error)
        }

        return profileInterest
    }

    func delete(id: ProfileInterest.ID) async throws(ProfileInterestRepositoryError) {
        let profileInterestModel: ProfileInterestModel?
        do {
            profileInterestModel = try await ProfileInterestModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let profileInterestModel else {
            throw .notFound
        }

        do {
            try await profileInterestModel.delete(force: true, on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

}
