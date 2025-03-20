//
//  FetchProfilePhotoError.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import ProfileApplication
import Vapor

extension FetchProfilePhotoError: AbortError {

    package var status: HTTPResponseStatus {
        switch self {
        case .notFound: .notFound
        case .unauthorized: .unauthorized
        case .unknown: .internalServerError
        }
    }

    package var reason: String {
        localizedDescription
    }

}
