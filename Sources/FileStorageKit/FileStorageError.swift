//
//  FileStorageError.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation

package enum FileStorageError: Error, Equatable {

    case invalidURL
    case notFound
    case network(Error)
    case unknown(Error? = nil)

    package static func == (lhs: FileStorageError, rhs: FileStorageError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            true
        case (.notFound, .notFound):
            true
        case (.network(let lhsError), .network(let rhsError)):
            lhsError.localizedDescription == rhsError.localizedDescription
        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            false
        }
    }

}
