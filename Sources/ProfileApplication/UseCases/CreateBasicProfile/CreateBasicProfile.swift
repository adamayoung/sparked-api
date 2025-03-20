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
        input: CreateBasicProfileInput,
        userContext: some UserContext
    ) async throws(CreateBasicProfileError) -> BasicProfileDTO {
        guard userContext.canWrite(ownerID: input.ownerID) else {
            throw .unauthorized
        }

        try await validate(input: input)

        let basicProfile = BasicProfileMapper.map(from: input)
        try await create(basicProfile)

        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

}

extension CreateBasicProfile {

    private func create(_ basicProfile: BasicProfile) async throws(CreateBasicProfileError) {
        do {
            try await repository.create(basicProfile)
        } catch BasicProfileRepositoryError.duplicate {
            throw .profileAlreadyExistsForUser(userID: basicProfile.ownerID)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension CreateBasicProfile {

    private func validate(input: CreateBasicProfileInput) async throws(CreateBasicProfileError) {
        try await validate(userID: input.ownerID)
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
