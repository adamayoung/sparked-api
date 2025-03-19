//
//  CacheFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import Logging

package final class CacheFactory {

    private init() {}

    package static func makeInMemoryCacheStore(logger: Logger) -> some CacheStore {
        InMemoryCacheStore(logger: logger)
    }

}
