//
//  InMemoryCacheStore.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

actor InMemoryCacheStore: CacheStore {

    static let shared = InMemoryCacheStore()

    private let cache = NSCache<NSString, Box>()

    private init() {}

    func get<CacheItem: Codable & Sendable>(forKey key: String) async throws -> CacheItem? {
        let nsKey = key as NSString
        guard let cacheItem = cache.object(forKey: nsKey)?.value as? CacheItem else {
            print("Cache MISS: \(key)")
            return nil
        }

        print("Cache HIT: \(key)")
        return cacheItem
    }

    func set(_ cacheItem: (some Codable & Sendable)?, forKey key: String) async throws {
        let nsKey = key as NSString
        print("Cache SET: \(key)")

        guard let cacheItem else {
            cache.removeObject(forKey: nsKey)
            return
        }

        cache.setObject(Box(cacheItem), forKey: nsKey)
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
