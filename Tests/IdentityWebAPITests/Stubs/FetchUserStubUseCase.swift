//
//  FetchUserStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication

final class FetchUserStubUseCase: FetchUserUseCase, @unchecked Sendable {

    var executeResult: Result<UserDTO, FetchUserError> = .failure(.unknown())
    private(set) var lastExecuteID: UserDTO.ID?

    init() {}

    func execute(id: UserDTO.ID) async throws(FetchUserError) -> UserDTO {
        lastExecuteID = id

        return try executeResult.get()
    }

}
