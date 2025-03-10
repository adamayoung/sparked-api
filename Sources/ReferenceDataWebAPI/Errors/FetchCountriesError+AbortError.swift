//
//  FetchCountriesError+AbortError.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataApplication
import Vapor

extension FetchCountriesError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
