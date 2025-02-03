//
//  FetchBasicProfileStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain

final class FetchBasicProfileStubUseCase: FetchBasicProfileUseCase, @unchecked Sendable {

    var executeIDResult: Result<BasicProfile, FetchBasicProfileError> = .failure(.unknown())
    private(set) var lastExecuteIDID: BasicProfile.ID?

    var executeUserIDResult: Result<BasicProfile, FetchBasicProfileError> = .failure(.unknown())
    private(set) var lastExecuteUserIDUserID: UUID?

    init() {}

    func execute(id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile {
        lastExecuteIDID = id

        return try executeIDResult.get()
    }

    func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile {
        lastExecuteUserIDUserID = userID

        return try executeUserIDResult.get()
    }

}
