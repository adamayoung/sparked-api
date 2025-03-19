//
//  InMemoryCacheStore.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import Logging

actor InMemoryCacheStore: CacheStore {

    @CacheActor private static let cache = NSCache<NSString, Box>()
    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    @CacheActor
    func get<CacheItem: Codable & Sendable>(forKey key: String) async throws -> CacheItem? {
        let nsKey = key as NSString
        guard let cacheItem = Self.cache.object(forKey: nsKey)?.value as? CacheItem else {
            logger.info("Cache MISS: \(key)")
            return nil
        }

        logger.info("Cache HIT: \(key)")
        return cacheItem
    }

    @CacheActor
    func set(_ cacheItem: (some Codable & Sendable)?, forKey key: String) async throws {
        let nsKey = key as NSString
        logger.info("Cache SET: \(key)")

        guard let cacheItem else {
            Self.cache.removeObject(forKey: nsKey)
            return
        }

        Self.cache.setObject(Box(cacheItem), forKey: nsKey)
    }

}

extension InMemoryCacheStore {

    private final class Box: AnyObject {
        let value: Any

        init(_ value: Any) {
            self.value = value
        }
    }

}
