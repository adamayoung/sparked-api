//
//  ProfileInterestRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

package protocol ProfileInterestRepository {

    func create(_ profileInterest: ProfileInterest) async throws(ProfileInterestRepositoryError)

    func fetchAll(
        forProfileID profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> [ProfileInterest]

    func fetch(
        byID id: ProfileInterest.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest

    func fetch(
        byInterestID interestID: Interest.ID,
        for profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest

    func delete(id: ProfileInterest.ID) async throws(ProfileInterestRepositoryError)

}

package enum ProfileInterestRepositoryError: Error, Equatable {

    case duplicate
    case notFound
    case unknown(Error? = nil)

    package static func == (
        lhs: ProfileInterestRepositoryError,
        rhs: ProfileInterestRepositoryError
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
