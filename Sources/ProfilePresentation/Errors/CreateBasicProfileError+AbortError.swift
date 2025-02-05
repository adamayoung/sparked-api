//
//  CreateBasicProfileError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import ProfileApplication
import Vapor

extension CreateBasicProfileError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .userNotFound: .notFound
        case .profileAlreadyExistsForUser: .badRequest
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
