//
//  AddProfilePhotoError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import ProfileApplication
import Vapor

extension AddProfilePhotoError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .profileNotFound: .notFound
        case .tooManyPhotos: .badRequest
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
