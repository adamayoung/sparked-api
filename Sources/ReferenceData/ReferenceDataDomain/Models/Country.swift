//
//  Country.swift
//  SparkedAPI
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package struct Country: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let code: String
    package let name: String
    package let nameKey: String

    package init(
        id: UUID,
        code: String,
        name: String,
        nameKey: String
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.nameKey = nameKey
    }

}
