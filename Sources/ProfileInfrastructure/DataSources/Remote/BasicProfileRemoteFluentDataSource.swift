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

final class BasicProfileRemoteFluentDataSource: BasicProfileRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func create(_ basicProfile: BasicProfile) async throws(BasicProfileRepositoryError) {
        var existingBasicProfile: BasicProfile?
        do {
            existingBasicProfile = try await fetch(byUserID: basicProfile.ownerID)
        } catch BasicProfileRepositoryError.notFound {
            existingBasicProfile = nil
        } catch let error {
            throw error
        }

        guard existingBasicProfile == nil else {
            throw .duplicate
        }

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        do {
            try await basicProfileModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    func fetch(byID id: BasicProfile.ID) async throws(BasicProfileRepositoryError) -> BasicProfile {
        let basicProfileModel: BasicProfileModel?
        do {
            basicProfileModel = try await BasicProfileModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let basicProfileModel else {
            throw .notFound
        }

        let basicProfile: BasicProfile
        do {
            basicProfile = try BasicProfileMapper.map(from: basicProfileModel)
        } catch let error {
            throw .unknown(error)
        }

        return basicProfile
    }

    func fetch(byUserID userID: UUID) async throws(BasicProfileRepositoryError) -> BasicProfile {
        let basicProfileModel: BasicProfileModel?
        do {
            basicProfileModel = try await BasicProfileModel.query(on: database)
                .filter(\.$ownerID == userID)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let basicProfileModel else {
            throw .notFound
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
