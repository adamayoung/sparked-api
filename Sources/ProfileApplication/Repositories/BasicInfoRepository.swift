//
//  BasicInfoRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import ProfileDomain

package protocol BasicInfoRepository {

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError)

    func fetch(byID id: BasicInfo.ID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(byOwnerID ownerID: User.ID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(
        byProfileID profileID: BasicProfile.ID
    ) async throws(BasicInfoRepositoryError) -> BasicInfo

}

package enum BasicInfoRepositoryError: Error, Equatable {

    case duplicate
    case notFound
    case unknown(Error? = nil)

    package static func == (
        lhs: BasicInfoRepositoryError,
        rhs: BasicInfoRepositoryError
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
