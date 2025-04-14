//
//  EducationLevelResponseModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Vapor

struct EducationLevelResponseModel: Equatable, Content {

    let id: UUID
    let name: String
    let nameKey: String

}
