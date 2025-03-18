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
    private let userRepository: any UserRepository

    init(
        repository: some BasicProfileRepository,
        userRepository: some UserRepository
    ) {
        self.repository = repository
        self.userRepository = userRepository
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
        do {
            _ = try await userRepository.fetch(byID: userID)
        } catch UserRepositoryError.notFound {
            throw .userNotFound(userID: userID)
        } catch let error {
            throw .unknown(error)
        }
    }

}
