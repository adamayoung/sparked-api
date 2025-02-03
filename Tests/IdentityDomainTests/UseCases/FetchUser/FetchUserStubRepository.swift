//
//  FetchUserStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain

final class FetchUserStubRepository: FetchUserRepository {

    var fetchResult: Result<User, FetchUserError> = .failure(.unknown(nil))
    private(set) var lastFetchID: User.ID?

    init() {}

    func fetch(byID id: User.ID) async throws(FetchUserError) -> User {
        lastFetchID = id

        return try fetchResult.get()
    }

}
