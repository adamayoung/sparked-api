//
//  CacheStore.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

protocol CacheStore: Actor {

    func get<CacheItem: Codable & Sendable>(forKey key: String) async throws -> CacheItem?

    func set(_ cacheItem: (some Codable & Sendable)?, forKey key: String) async throws

}
