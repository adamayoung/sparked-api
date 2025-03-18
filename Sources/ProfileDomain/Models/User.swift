//
//  User.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package struct User: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let email: String

    package init(
        id: UUID,
        email: String
    ) {
        self.id = id
        self.email = email
    }

}
