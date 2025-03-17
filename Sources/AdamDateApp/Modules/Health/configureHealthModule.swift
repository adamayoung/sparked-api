//
//  configureHealthModule.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import HealthWebAPI
import Vapor

func configureHealthModule(on app: Application) {
    app.healthServices.use(.default)
}
