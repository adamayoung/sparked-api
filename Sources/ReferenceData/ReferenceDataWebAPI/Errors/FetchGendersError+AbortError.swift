//
//  FetchGendersError+AbortError.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataApplication
import Vapor

extension FetchGendersError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
