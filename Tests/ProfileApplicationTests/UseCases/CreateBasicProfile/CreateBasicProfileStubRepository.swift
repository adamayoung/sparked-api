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

    var createResult: Result<Void, CreateBasicProfileError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateBasicProfile: BasicProfile?

    init() {}

    func create(_ basicProfile: BasicProfile) async throws(CreateBasicProfileError) {
        createWasCalled = true
        lastCreateBasicProfile = basicProfile

        try createResult.get()
    }

}
