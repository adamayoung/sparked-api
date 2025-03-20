//
//  EducationLevelDTO.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package struct EducationLevelDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let name: String
    package let nameKey: String

    package init(
        id: UUID,
        name: String,
        nameKey: String
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
    }

}
