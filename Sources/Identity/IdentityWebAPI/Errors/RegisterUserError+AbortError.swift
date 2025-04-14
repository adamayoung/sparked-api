//
//  RegisterUserError.swift
//  SparkedAPI
//
//  Created by Adam Young on 29/01/2025.
//

import IdentityApplication
import Vapor

extension RegisterUserError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .validation: .badRequest
        case .emailAlreadyExists: .badRequest
        case .roleNotFound: .notFound
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
