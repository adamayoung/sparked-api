//
//  Gender.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package struct Gender: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let code: String
    package let name: String

    package init(
        id: UUID,
        code: String,
        name: String
    ) {
        self.id = id
        self.code = code
        self.name = name
    }

}
