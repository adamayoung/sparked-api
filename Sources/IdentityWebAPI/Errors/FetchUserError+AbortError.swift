//
//  FetchUserError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import IdentityApplication
import Vapor

extension FetchUserError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFoundByID: .notFound
        case .notFoundByEmail: .notFound
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
