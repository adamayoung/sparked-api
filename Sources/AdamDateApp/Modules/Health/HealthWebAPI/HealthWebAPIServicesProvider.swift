//
//  HealthWebAPIServicesProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import HealthWebAPI
import Vapor

extension Application.HealthServices.Provider {

    static var `default`: Self {
        Self { app in
            app.healthServices.use { app in
                HealthAdapterFactory.makeHealthService(
                    database: app.db(.adamDate),
                    fileStorage: app.fileStorage
                )
            }
        }
    }

}
