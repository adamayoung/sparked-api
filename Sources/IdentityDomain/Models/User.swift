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
    package let familyName: String
    package let email: String
    package let passwordHash: String
    package let isVerified: Bool
    package let isActive: Bool

    package var fullName: String {
        var components = PersonNameComponents()
        components.givenName = firstName
        components.familyName = familyName

        let formatter = PersonNameComponentsFormatter()
        return formatter.string(from: components)
    }

    package init(
        id: UUID = UUID(),
        firstName: String,
        familyName: String,
        email: String,
        passwordHash: String,
        isVerified: Bool = false,
        isActive: Bool = false
    ) {
        self.id = id
        self.firstName = firstName
        self.familyName = familyName
        self.email = email
        self.passwordHash = passwordHash
        self.isVerified = isVerified
        self.isActive = isActive
    }

}
