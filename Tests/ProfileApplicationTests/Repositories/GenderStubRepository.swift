//
//  GenderStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class GenderStubRepository: GenderRepository {

    var fetchByIDResult: Result<Gender, GenderRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: Gender.ID?

    init() {}

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

}
