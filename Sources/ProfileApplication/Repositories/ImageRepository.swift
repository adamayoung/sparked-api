//
//  ImageRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/03/2025.
//

import Foundation
import ProfileDomain

package protocol ImageRepository {

    func create(_ photoData: Data, filename: String) async throws

    func delete(filename: String) async throws

    func url(for filename: String) async throws -> URL

}

package enum ImageRepositoryError: Error, Equatable {

    case unknown(Error? = nil)

    package static func == (
        lhs: ImageRepositoryError,
        rhs: ImageRepositoryError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
