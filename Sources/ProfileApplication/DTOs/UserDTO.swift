//
//  UserDTO.swift
//  AdamDateApp
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

    package init(
        id: UUID,
        firstName: String,
        familyName: String,
        fullName: String,
        email: String
    ) {
        self.id = id
        self.firstName = firstName
        self.familyName = familyName
        self.fullName = fullName
        self.email = email
    }

}
