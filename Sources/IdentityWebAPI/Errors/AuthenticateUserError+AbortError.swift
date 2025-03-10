//
//  AuthenticateUserError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import IdentityApplication
import Vapor

extension AuthenticateUserError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .invalidEmailOrPassword: .unauthorized
        case .notVerified: .forbidden
        case .userDisabled: .notFound
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
