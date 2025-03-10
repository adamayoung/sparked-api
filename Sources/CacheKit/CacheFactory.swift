//
//  CacheFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation

package final class CacheFactory {

    private init() {}

    package static func makeCacheStore() -> some CacheStore {
        InMemoryCacheStore.shared
    }

}
