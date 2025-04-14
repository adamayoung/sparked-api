//
//  Request+Services.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/04/2025.
//

import Vapor

extension Request {

    var healthService: any HealthService {
        application.healthServices.makeHealthService
    }

}
