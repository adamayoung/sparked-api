//
//  FetchBasicProfileError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import ProfileDomain
import Vapor

extension FetchBasicProfileError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFound: .notFound
        case .userNotFound: .notFound
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
