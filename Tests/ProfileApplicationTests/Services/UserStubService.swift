//
//  UserStubService.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ProfileApplication

final class UserStubService: UserService {

    var fetchByIDResult: Result<UserDTO, UserServiceError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: UUID?

    init() {}

    func fetch(byID id: UUID) async throws(UserServiceError) -> UserDTO {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

}
