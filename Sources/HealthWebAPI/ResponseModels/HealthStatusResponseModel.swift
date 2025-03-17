//
//  HealthStatusResponseModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import Vapor

struct HealthStatusResponseModel: Content {

    let database: Bool
    let storage: Bool
    let uptime: String

}
