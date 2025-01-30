//
//  FetchUserStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import IdentityEntities

final class FetchUserStubUseCase: FetchUserUseCase, @unchecked Sendable {

    var executeResult: Result<User, FetchUserError> = .failure(.unknown())
    private(set) var lastExecuteID: User.ID?

    func execute(id: User.ID) async throws(FetchUserError) -> User {
        lastExecuteID = id

        return try executeResult.get()
    }

}
