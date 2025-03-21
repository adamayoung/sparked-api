//
//  StarSign.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package struct StarSign: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let name: String

    package init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }

}
