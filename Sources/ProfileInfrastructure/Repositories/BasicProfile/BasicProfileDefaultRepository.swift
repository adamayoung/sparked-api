//
//  BasicProfileDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class BasicProfileDefaultRepository: BasicProfileRepository {

    private let remoteDataSource: any BasicProfileRemoteDataSource

    init(remoteDataSource: some BasicProfileRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ basicProfile: BasicProfile) async throws(BasicProfileRepositoryError) {
        try await remoteDataSource.create(basicProfile)
    }

    func fetch(
        byID id: BasicProfile.ID
    ) async throws(BasicProfileRepositoryError) -> BasicProfile {
        let basicProfile = try await remoteDataSource.fetch(byID: id)

        return basicProfile
    }

    func fetch(byUserID userID: UUID) async throws(BasicProfileRepositoryError) -> BasicProfile {
        let basicProfile = try await remoteDataSource.fetch(byUserID: userID)

        return basicProfile
    }

}
