//
//  ReferenceDataGraphQLFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import ReferenceDataApplication

package final class ReferenceDataGraphQLFactory: Sendable {

    private init() {}

    package static func makeResolver() -> some ReferenceDataResolver {
        ReferenceDataUseCaseResolver()
    }

}
