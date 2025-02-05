//
//  Country.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package struct Country: Identifiable, Equatable {

    package let id: String
    package let name: String

    package init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
