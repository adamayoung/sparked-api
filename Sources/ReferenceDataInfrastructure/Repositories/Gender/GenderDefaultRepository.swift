//
//  GenderDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class GenderDefaultRepository: GenderRepository {

    private let remoteDataSource: any GenderRemoteDataSource
    private let cacheDataSource: any GenderCacheDataSource

    init(
        remoteDataSource: some GenderRemoteDataSource,
        cacheDataSource: some GenderCacheDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
    }

    func fetchAll() async throws(GenderRepositoryError) -> [Gender] {
        if let cachedGenders = try? await cacheDataSource.fetchAll() {
            return cachedGenders
        }

        let genders = try await remoteDataSource.fetchAll()
        try? await cacheDataSource.setGenders(genders)

        return genders
    }

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender {
        if let cachedGender = try? await cacheDataSource.fetch(byID: id) {
            return cachedGender
        }

        let gender = try await remoteDataSource.fetch(byID: id)
        try? await cacheDataSource.setGender(gender)

        return gender
    }

}
