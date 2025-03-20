//
//  FetchInterestsError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import ReferenceDataApplication
import Vapor

extension FetchInterestsError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
