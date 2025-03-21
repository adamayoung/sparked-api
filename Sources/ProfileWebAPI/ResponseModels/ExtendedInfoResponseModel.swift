//
//  ExtendedInfoResponseModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Vapor

struct ExtendedInfoResponseModel: Content, Equatable {

    let id: UUID
    let height: Double?
    let educationLevelID: UUID?
    let starSignID: UUID?

}
