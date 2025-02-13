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

    func fetch(byID id: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfo = try await remoteDataSource.fetch(byID: id)

        return basicInfo
    }

    func fetch(byUserID userID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfo = try await remoteDataSource.fetch(byUserID: userID)

        return basicInfo
    }

    func fetch(byProfileID profileID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfo = try await remoteDataSource.fetch(byProfileID: profileID)

        return basicInfo
    }

}
