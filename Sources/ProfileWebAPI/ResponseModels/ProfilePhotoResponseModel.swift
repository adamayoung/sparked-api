//
//  ProfilePhotoResponseModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/03/2025.
//

import Vapor

struct ProfilePhotoResponseModel: Content, Equatable {

    let id: UUID
    let url: URL

}
