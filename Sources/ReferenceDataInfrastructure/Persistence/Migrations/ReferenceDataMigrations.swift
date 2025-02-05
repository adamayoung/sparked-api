//
//  ReferenceDataMigrations.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

package func migrations() -> [Migration] {
    [
        GenderMigrationV1(),

        CountryMigrationV1()
    ]
}
