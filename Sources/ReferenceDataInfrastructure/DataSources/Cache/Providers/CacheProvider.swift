//
//  CacheProvider.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package protocol CacheProvider: Actor {

    func get<CacheItem: Codable & Sendable>(
        forKey key: String
    ) async throws(CacheProviderError) -> CacheItem?

    func set(
        _ cacheItem: (some Codable & Sendable)?,
        forKey key: String
    ) async throws(CacheProviderError)

}

package enum CacheProviderError: LocalizedError {

    case unknown(Error? = nil)

    package static func == (lhs: CacheProviderError, rhs: CacheProviderError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
