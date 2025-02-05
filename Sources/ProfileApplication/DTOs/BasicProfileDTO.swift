//
//  BasicProfileDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct BasicProfileDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let userID: UUID
    package let displayName: String
    package let birthDate: Date
    package let age: Int

    package init(
        id: UUID,
        userID: UUID,
        displayName: String,
        birthDate: Date,
        age: Int
    ) {
        self.id = id
        self.userID = userID
        self.displayName = displayName
        self.birthDate = birthDate
        self.age = age
    }

}
