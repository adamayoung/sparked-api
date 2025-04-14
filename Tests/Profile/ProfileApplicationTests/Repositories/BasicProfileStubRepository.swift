//
//  CreateBasicProfileStubRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class BasicProfileStubRepository: BasicProfileRepository {

    var createResult: Result<Void, BasicProfileRepositoryError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateBasicProfile: BasicProfile?

    var fetchByIDResult: Result<BasicProfile, BasicProfileRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: BasicProfile.ID?

    var fetchByUserIDResult: Result<BasicProfile, BasicProfileRepositoryError> = .failure(
        .unknown())
    private(set) var fetchByUserIDWasCalled = false
    private(set) var lastFetchByUserIDUserID: BasicProfile.ID?

    init() {}

    func create(_ basicProfile: BasicProfile) async throws(BasicProfileRepositoryError) {
        createWasCalled = true
        lastCreateBasicProfile = basicProfile

        try createResult.get()
    }

    func fetch(byID id: BasicProfile.ID) async throws(BasicProfileRepositoryError) -> BasicProfile {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

    func fetch(byUserID userID: UUID) async throws(BasicProfileRepositoryError) -> BasicProfile {
        fetchByUserIDWasCalled = true
        lastFetchByUserIDUserID = userID

        return try fetchByUserIDResult.get()
    }

}
