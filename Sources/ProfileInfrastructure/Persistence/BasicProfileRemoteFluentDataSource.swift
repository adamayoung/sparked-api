//
//  BasicProfileRemoteFluentDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation
import ProfileApplication
import ProfileDomain

package final class BasicProfileRemoteFluentDataSource: BasicProfileRemoteDataSource {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    package func create(_ basicProfile: BasicProfile) async throws(CreateBasicProfileError) {
        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        var existingBasicProfile: BasicProfile?
        do {
            existingBasicProfile = try await fetch(byUserID: basicProfileModel.userID)
        } catch FetchBasicProfileError.notFoundForUser {
            existingBasicProfile = nil
        } catch let error {
            throw .unknown(error)
        }

        guard existingBasicProfile == nil else {
            throw .profileAlreadyExistsForUser(userID: basicProfileModel.userID)
        }

        do {
            try await basicProfileModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    package func fetch(
        byID id: BasicProfile.ID
    ) async throws(FetchBasicProfileError) -> BasicProfile {
        let basicProfileModel: BasicProfileModel?
        do {
            basicProfileModel = try await BasicProfileModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let basicProfileModel else {
            throw .notFound(profileID: id)
        }

        let basicProfile: BasicProfile
        do {
            basicProfile = try BasicProfileMapper.map(from: basicProfileModel)
        } catch let error {
            throw .unknown(error)
        }

        return basicProfile
    }

    package func fetch(byUserID userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile {
        let basicProfileModel: BasicProfileModel?
        do {
            basicProfileModel = try await BasicProfileModel.query(on: database)
                .filter(\.$userID == userID).first()
        } catch let error {
            throw .unknown(error)
        }

        guard let basicProfileModel else {
            throw .notFoundForUser(userID: userID)
        }

        let basicProfile: BasicProfile
        do {
            basicProfile = try BasicProfileMapper.map(from: basicProfileModel)
        } catch let error {
            throw .unknown(error)
        }

        return basicProfile
    }

}
