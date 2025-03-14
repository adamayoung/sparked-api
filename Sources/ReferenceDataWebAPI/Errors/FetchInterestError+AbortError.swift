//
//  FetchInterestError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import ReferenceDataApplication
import Vapor

extension FetchInterestError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFound: .notFound
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
