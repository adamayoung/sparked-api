//
//  AuthFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import Vapor

package final class AuthFactory {

    private init() {}

    package static func makePasswordHasher(
        vaporPasswordHasher: some Vapor.PasswordHasher
    ) -> some PasswordHasher {
        VaporPasswordHasher(hasher: vaporPasswordHasher)
    }

}
