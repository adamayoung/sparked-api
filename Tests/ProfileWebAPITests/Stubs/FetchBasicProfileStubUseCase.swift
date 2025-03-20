//
//  FetchBasicProfileStubUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication

final class FetchBasicProfileStubUseCase: FetchBasicProfileUseCase, @unchecked Sendable {

    var executeIDResult: Result<BasicProfileDTO, FetchBasicProfileError> = .failure(.unknown())
    private(set) var executeIDWasCalled = false
    private(set) var lastExecuteIDParameters:
        (
            id: BasicProfileDTO.ID,
            userContext: any UserContext
        )?

    var executeUserIDResult: Result<BasicProfileDTO, FetchBasicProfileError> = .failure(.unknown())
    private(set) var executeUserIDWasCalled = false
    private(set) var lastExecuteUserIDParameters:
        (
            userID: UUID,
            userContext: any UserContext
        )?

    init() {}

    func execute(
        id: BasicProfileDTO.ID,
        userContext: some UserContext
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        executeIDWasCalled = true
        lastExecuteIDParameters = (id: id, userContext: userContext)

        return try executeIDResult.get()
    }

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        executeUserIDWasCalled = true
        lastExecuteUserIDParameters = (userID: userID, userContext: userContext)

        return try executeUserIDResult.get()
    }

}
