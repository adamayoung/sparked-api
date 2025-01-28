//
//  UserMigrations.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

package func migrations() -> [Migration] {
    [
        UserMigrationV1()
    ]
}
