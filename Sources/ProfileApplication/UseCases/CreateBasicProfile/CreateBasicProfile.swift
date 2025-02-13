//
//  CreateBasicProfile.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileDomain

final class CreateBasicProfile: CreateBasicProfileUseCase {

    private let repository: any BasicProfileRepository
    private let userService: any UserService

    init(
        repository: some BasicProfileRepository,
        userService: some UserService
    ) {
        self.repository = repository
        self.userService = userService
    }

    func execute(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfileDTO {
        try await validate(input: input)

        let basicProfile = BasicProfileMapper.map(from: input)
        do {
            try await repository.create(basicProfile)
        } catch BasicProfileRepositoryError.duplicate {
            throw .profileAlreadyExistsForUser(userID: input.userID)
        } catch let error {
            throw .unknown(error)
        }

        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

}

extension CreateBasicProfile {

    private func validate(input: CreateBasicProfileInput) async throws(CreateBasicProfileError) {
        try await validate(userID: input.userID)
    }

    private func validate(userID: UUID) async throws(CreateBasicProfileError) {
        let userExists: Bool
        do {
            userExists = try await userService.doesUserExist(withID: userID)
        } catch let error {
            throw .unknown(error)
        }

        guard userExists else {
            throw .userNotFound(userID: userID)
        }
    }

}
