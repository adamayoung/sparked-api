//
//  ChangeProfilePhotoOrderError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import ProfileApplication
import Vapor

extension ChangeProfilePhotoOrderError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .profileNotFound: .notFound
        case .profilePhotoNotFound: .notFound
        case .invalidIndex: .badRequest
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
