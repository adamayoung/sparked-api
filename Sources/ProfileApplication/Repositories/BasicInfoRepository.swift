//
//  BasicInfoRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import ProfileDomain

package protocol BasicInfoRepository {

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError)

    func fetch(byID id: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(byUserID userID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(byProfileID profileID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo

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
