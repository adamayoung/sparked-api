//
//  CreateExtendedInfoRequestModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Vapor

struct CreateExtendedInfoRequestModel: Content {

    let height: Double?
    let educationLevelID: UUID?
    let starSignID: UUID?

}
