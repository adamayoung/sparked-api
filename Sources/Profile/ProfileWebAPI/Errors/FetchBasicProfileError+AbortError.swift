//
//  FetchBasicProfileError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import ProfileApplication
import Vapor

extension FetchBasicProfileError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFound: .notFound
        case .notFoundForUser: .notFound
        case .userNotFound: .notFound
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
