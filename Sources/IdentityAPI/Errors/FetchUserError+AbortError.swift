//
//  FetchUserError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import IdentityDomain
import Vapor

extension FetchUserError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFound: return .notFound
        case .unknown: return .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
