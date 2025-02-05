//
//  RegisterUserError.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import IdentityApplication
import Vapor

extension RegisterUserError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .emailAlreadyExists: .badRequest
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
