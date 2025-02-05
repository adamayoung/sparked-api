//
//  CreateBasicProfileStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class CreateBasicProfileStubRepository: CreateBasicProfileRepository {

    var createResult: Result<BasicProfile, CreateBasicProfileError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateInput: CreateBasicProfileInput?

    init() {}

    func create(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile {
        createWasCalled = true
        lastCreateInput = input

        return try createResult.get()
    }

}
