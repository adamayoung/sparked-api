//
//  EducationLevelDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class EducationLevelDefaultRepository: EducationLevelRepository {

    private let remoteDataSource: any EducationLevelRemoteDataSource
    private let cacheDataSource: any EducationLevelCacheDataSource

    init(
        remoteDataSource: some EducationLevelRemoteDataSource,
        cacheDataSource: some EducationLevelCacheDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
    }

    func fetchAll() async throws(EducationLevelRepositoryError) -> [EducationLevel] {
        if let cachedEducationLevels = try? await cacheDataSource.fetchAll() {
            return cachedEducationLevels
        }

        let educationLevels = try await remoteDataSource.fetchAll()
        try? await cacheDataSource.setEducationLevels(educationLevels)

        return educationLevels
    }

    func fetch(
        byID id: EducationLevel.ID
    ) async throws(EducationLevelRepositoryError) -> EducationLevel {
        if let cachedEducationLevel = try? await cacheDataSource.fetch(byID: id) {
            return cachedEducationLevel
        }

        let educationLevel = try await remoteDataSource.fetch(byID: id)
        try? await cacheDataSource.setEducationLevel(educationLevel)

        return educationLevel
    }

}
