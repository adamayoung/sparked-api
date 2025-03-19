//
//  RoleDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation

package struct RoleDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let code: String
    package let name: String
    package let description: String

    package init(
        id: UUID,
        code: String,
        name: String,
        description: String
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.description = description
    }

}
