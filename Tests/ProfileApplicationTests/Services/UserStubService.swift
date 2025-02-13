//
//  UserStubService.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileApplication

final class UserStubService: UserService {

    var doesUserExistResult: Result<Bool, UserServiceError> = .success(true)
    private(set) var doesUserExistWasCalled = false
    private(set) var lastDoesUserExistWithIDID: UUID?

    func doesUserExist(withID id: UUID) async throws(UserServiceError) -> Bool {
        doesUserExistWasCalled = true
        lastDoesUserExistWithIDID = id
        return try doesUserExistResult.get()
    }

}
