//
//  CReateBasicInfoError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import ProfileApplication
import Vapor

extension CreateBasicInfoError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .profileNotFound: .notFound
        case .countryNotFound: .badRequest
        case .genderNotFound: .badRequest
        case .basicInfoAlreadyExistsForProfile: .badRequest
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
