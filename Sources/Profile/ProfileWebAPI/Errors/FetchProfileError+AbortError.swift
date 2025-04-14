//
//  FetchProfileError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/03/2025.
//

import ProfileApplication
import Vapor

extension FetchProfileError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFound: .notFound
        case .userNotFound: .notFound
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
