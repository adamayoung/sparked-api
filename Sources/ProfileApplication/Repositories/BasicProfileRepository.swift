//
//  BasicProfileRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import ProfileDomain

package protocol BasicProfileRepository {

    func create(_ basicProfile: BasicProfile) async throws(BasicProfileRepositoryError)

    func fetch(byID id: BasicProfile.ID) async throws(BasicProfileRepositoryError) -> BasicProfile

    func fetch(byUserID userID: UUID) async throws(BasicProfileRepositoryError) -> BasicProfile

}

package enum BasicProfileRepositoryError: Error, Equatable {

    case duplicate
    case notFound
    case unknown(Error? = nil)

    package static func == (
        lhs: BasicProfileRepositoryError,
        rhs: BasicProfileRepositoryError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.duplicate, .duplicate):
            return true
        case (.notFound, .notFound):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }

}
