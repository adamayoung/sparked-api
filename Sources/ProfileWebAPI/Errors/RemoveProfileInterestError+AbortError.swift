//
//  RemoveProfileInterestError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import ProfileApplication
import Vapor

extension RemoveProfileInterestError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .profileNotFound: .notFound
        case .interestNotFound: .notFound
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
