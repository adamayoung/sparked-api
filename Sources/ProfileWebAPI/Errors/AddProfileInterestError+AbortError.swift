//
//  AddProfileInterestError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import ProfileApplication
import Vapor

extension AddProfileInterestError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .profileNotFound: .notFound
        case .interestNotFound: .notFound
        case .tooManyInterests: .badRequest
        case .duplicateInterest: .conflict
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
