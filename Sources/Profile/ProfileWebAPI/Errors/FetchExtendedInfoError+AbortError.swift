//
//  FetchExtendedInfoError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import ProfileApplication
import Vapor

extension FetchExtendedInfoError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFound: .notFound
        case .notFoundForUser: .notFound
        case .profileNotFound: .notFound
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
