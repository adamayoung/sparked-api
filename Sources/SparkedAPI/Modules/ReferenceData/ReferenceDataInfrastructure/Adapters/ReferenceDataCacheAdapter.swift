//
//  ReferenceDataCacheAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import CacheKit
import Foundation
import ReferenceDataInfrastructure

actor ReferenceDataCacheAdapter: CacheProvider {

    private let cacheStore: any CacheStore

    init(cacheStore: some CacheStore) {
        self.cacheStore = cacheStore
    }

    func get<CacheItem: Codable & Sendable>(
        forKey key: String
    ) async throws(CacheProviderError) -> CacheItem? {
        do {
            return try await cacheStore.get(forKey: key)
        } catch let error {
            throw .unknown(error)
        }
    }

    func set(
        _ cacheItem: (some Decodable & Encodable & Sendable)?,
        forKey key: String
    ) async throws(CacheProviderError) {
        do {
            try await cacheStore.set(cacheItem, forKey: key)
        } catch let error {
            throw .unknown(error)
        }
    }

}
