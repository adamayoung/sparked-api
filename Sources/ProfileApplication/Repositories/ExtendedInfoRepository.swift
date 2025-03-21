//
//  ExtendedInfoRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

package protocol ExtendedInfoRepository {

    func create(_ extendedInfo: ExtendedInfo) async throws(ExtendedInfoRepositoryError)

    func fetch(byID id: ExtendedInfo.ID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo

    func fetch(byOwnerID ownerID: User.ID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo

    func fetch(
        byProfileID profileID: ExtendedInfo.ID
    ) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo

}

package enum ExtendedInfoRepositoryError: Error, Equatable {

    case duplicate
    case notFound
    case unknown(Error? = nil)

    package static func == (
        lhs: ExtendedInfoRepositoryError,
        rhs: ExtendedInfoRepositoryError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.duplicate, .duplicate):
            true

        case (.notFound, .notFound):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
