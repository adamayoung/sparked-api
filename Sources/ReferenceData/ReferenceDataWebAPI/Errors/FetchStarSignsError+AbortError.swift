//
//  FetchStarSignsError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import ReferenceDataApplication
import Vapor

extension FetchStarSignsError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
