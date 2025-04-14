//
//  FetchStarSignError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import ReferenceDataApplication
import Vapor

extension FetchStarSignError: AbortError {

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
