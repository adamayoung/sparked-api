//
//  StarSignDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class StarSignDefaultRepository: StarSignRepository {

    private let remoteDataSource: any StarSignRemoteDataSource
    private let cacheDataSource: any StarSignCacheDataSource

    init(
        remoteDataSource: some StarSignRemoteDataSource,
        cacheDataSource: some StarSignCacheDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
    }

    func fetchAll() async throws(StarSignRepositoryError) -> [StarSign] {
        if let cachedStarSigns = try? await cacheDataSource.fetchAll() {
            return cachedStarSigns
        }

        let starSigns = try await remoteDataSource.fetchAll()
        try? await cacheDataSource.setStarSigns(starSigns)

        return starSigns
    }

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign {
        if let cachedStarSign = try? await cacheDataSource.fetch(byID: id) {
            return cachedStarSign
        }

        let starSign = try await remoteDataSource.fetch(byID: id)
        try? await cacheDataSource.setStarSign(starSign)

        return starSign
    }

}
