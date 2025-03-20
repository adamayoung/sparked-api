//
//  CreateExtendedInfoError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import ProfileApplication
import Vapor

extension CreateExtendedInfoError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .profileNotFound: .notFound
        case .educationLevelNotFound: .badRequest
        case .starSignNotFound: .badRequest
        case .extendedInfoAlreadyExistsForProfile: .badRequest
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
