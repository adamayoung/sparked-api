//
//  HealthAdapterFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import FileStorageKit
import Fluent
import Foundation
import HealthWebAPI

final class HealthAdapterFactory {

    private init() {}

    static func makeHealthService(
        database: some Database,
        fileStorage: some FileStorage
    ) -> some HealthService {
        HealthServiceAdapter(
            database: database,
            fileStorage: fileStorage
        )
    }

}
