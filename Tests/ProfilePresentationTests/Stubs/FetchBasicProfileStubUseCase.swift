//
//  FetchBasicProfileStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication

final class FetchBasicProfileStubUseCase: FetchBasicProfileUseCase, @unchecked Sendable {

    var executeIDResult: Result<BasicProfileDTO, FetchBasicProfileError> = .failure(.unknown())
    private(set) var lastExecuteIDID: BasicProfileDTO.ID?

    var executeUserIDResult: Result<BasicProfileDTO, FetchBasicProfileError> = .failure(.unknown())
    private(set) var lastExecuteUserIDUserID: UUID?

    init() {}

    func execute(id: BasicProfileDTO.ID) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        lastExecuteIDID = id

        return try executeIDResult.get()
    }

    func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        lastExecuteUserIDUserID = userID

        return try executeUserIDResult.get()
    }

}
