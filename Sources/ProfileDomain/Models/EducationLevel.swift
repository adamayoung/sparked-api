//
//  EducationLevel.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package struct EducationLevel: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let name: String

    package init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }

}
