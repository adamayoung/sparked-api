//
//  User.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package struct User: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let firstName: String
    package let lastName: String
    package let email: String
    package let isVerified: Bool
    package let isActive: Bool

    package var fullName: String {
        var components = PersonNameComponents()
        components.givenName = firstName
        components.familyName = lastName

        let formatter = PersonNameComponentsFormatter()
        return formatter.string(from: components)
    }

    package init(
        id: UUID,
        firstName: String,
        lastName: String,
        email: String,
        isVerified: Bool,
        isActive: Bool
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.isVerified = isVerified
        self.isActive = isActive
    }

}
