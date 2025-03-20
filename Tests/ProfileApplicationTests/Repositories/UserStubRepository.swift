//
//  UserStubRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class UserStubRepository: UserRepository {

    var fetchByIDResult: Result<User, UserRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: User.ID?

    init() {}

    func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

}
