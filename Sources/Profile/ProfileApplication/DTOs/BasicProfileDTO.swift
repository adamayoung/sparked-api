//
//  BasicProfileDTO.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct BasicProfileDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let displayName: String
    package let birthDate: Date
    package let age: Int
    package let bio: String

    package init(
        id: UUID,
        displayName: String,
        birthDate: Date,
        age: Int,
        bio: String
    ) {
        self.id = id
        self.displayName = displayName
        self.birthDate = birthDate
        self.age = age
        self.bio = bio
    }

}
