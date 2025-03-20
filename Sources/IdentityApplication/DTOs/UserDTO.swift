//
//  UserDTO.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct UserDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let firstName: String
    package let familyName: String
    package let fullName: String
    package let email: String
    package let roles: [RoleDTO]
    package let isVerified: Bool
    package let isActive: Bool

    package init(
        id: UUID,
        firstName: String,
        familyName: String,
        fullName: String,
        email: String,
        roles: [RoleDTO],
        isVerified: Bool,
        isActive: Bool
    ) {
        self.id = id
        self.firstName = firstName
        self.familyName = familyName
        self.fullName = fullName
        self.email = email
        self.roles = roles
        self.isVerified = isVerified
        self.isActive = isActive
    }

}
