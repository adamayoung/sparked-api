//
//  BasicProfileFluentRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Fluent
import Foundation
import ProfileDomain

package final class BasicProfileFluentRepository: BasicProfileRepository {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    package func create(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile {
        let basicProfileModel = BasicProfileModelMapper.map(from: input)

        var existingBasicProfile: BasicProfile?
        do {
            existingBasicProfile = try await fetch(byUserID: basicProfileModel.userID)
        } catch let error {
            switch error {
            case .userNotFound: break
            default: throw .unknown(error)
            }
        }

        guard existingBasicProfile == nil else {
            throw .profileAlreadyExistsForUser(userID: basicProfileModel.userID)
        }

        do {
            try await basicProfileModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }

        let newBasicProfile: BasicProfile
        do {
            newBasicProfile = try BasicProfileMapper.map(from: basicProfileModel)
        } catch let error {
            throw .unknown(error)
        }

        return newBasicProfile
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
            throw .userNotFound(userID: userID)
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
