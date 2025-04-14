//
//  CreateBasicProfileError+AbortError.swift
//  SparkedAPI
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
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
