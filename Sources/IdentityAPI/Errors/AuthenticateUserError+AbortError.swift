//
//  AuthenticateUserError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import IdentityDomain
import Vapor

extension AuthenticateUserError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .invalidEmailOrPassword: return .unauthorized
        case .notVerified: return .forbidden
        case .userDisabled: return .notFound
        case .unknown: return .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
