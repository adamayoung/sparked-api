//
//  FetchBasicProfileStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class FetchBasicProfileStubRepository: FetchBasicProfileRepository {

    var fetchByIDResult: Result<BasicProfile, FetchBasicProfileError> = .failure(.unknown())
    var lastFetchByIDID: BasicProfile.ID?

    var fetchByUserIDResult: Result<BasicProfile, FetchBasicProfileError> = .failure(.unknown())
    var lastFetchByUserIDUserID: BasicProfile.ID?

    init() {}

    func fetch(byID id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile {
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

    func fetch(byUserID userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile {
        lastFetchByUserIDUserID = userID

        return try fetchByUserIDResult.get()
    }

}
