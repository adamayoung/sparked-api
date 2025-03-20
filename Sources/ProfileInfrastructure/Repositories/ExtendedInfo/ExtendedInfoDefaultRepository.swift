//
//  ExtendedInfoDefaultRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class ExtendedInfoDefaultRepository: ExtendedInfoRepository {

    private let remoteDataSource: any ExtendedInfoRemoteDataSource

    init(remoteDataSource: some ExtendedInfoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ extendedInfo: ExtendedInfo) async throws(ExtendedInfoRepositoryError) {
        try await remoteDataSource.create(extendedInfo)
    }

    func fetch(byID id: ExtendedInfo.ID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo {
        let extendedInfo = try await remoteDataSource.fetch(byID: id)

        return extendedInfo
    }

    func fetch(byOwnerID ownerID: User.ID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo
    {
        let extendedInfo = try await remoteDataSource.fetch(byOwnerID: ownerID)

        return extendedInfo
    }

    func fetch(
        byProfileID profileID: BasicProfile.ID
    ) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo {
        let extendedInfo = try await remoteDataSource.fetch(byProfileID: profileID)

        return extendedInfo
    }

}
