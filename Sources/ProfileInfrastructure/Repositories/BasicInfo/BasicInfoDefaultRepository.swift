//
//  BasicInfoDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class BasicInfoDefaultRepository: BasicInfoRepository {

    private let remoteDataSource: any BasicInfoRemoteDataSource

    init(remoteDataSource: some BasicInfoRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError) {
        try await remoteDataSource.create(basicInfo)
    }

    func fetch(byID id: BasicInfo.ID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfo = try await remoteDataSource.fetch(byID: id)

        return basicInfo
    }

    func fetch(byOwnerID ownerID: User.ID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfo = try await remoteDataSource.fetch(byOwnerID: ownerID)

        return basicInfo
    }

    func fetch(
        byProfileID profileID: BasicProfile.ID
    ) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfo = try await remoteDataSource.fetch(byProfileID: profileID)

        return basicInfo
    }

}
