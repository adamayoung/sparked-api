//
//  ProfileGraphQLFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import ProfileApplication

package final class ProfileGraphQLFactory: Sendable {

    private init() {}

    package static func makeResolver() -> some ProfileResolver {
        ProfileUseCaseResolver()
    }

}
