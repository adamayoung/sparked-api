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
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: BasicProfile.ID?

    var fetchByUserIDResult: Result<BasicProfile, FetchBasicProfileError> = .failure(.unknown())
    private(set) var fetchByUserIDWasCalled = false
    private(set) var lastFetchByUserIDUserID: BasicProfile.ID?

    init() {}

    func fetch(byID id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

    func fetch(byUserID userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile {
        fetchByUserIDWasCalled = true
        lastFetchByUserIDUserID = userID

        return try fetchByUserIDResult.get()
    }

}
