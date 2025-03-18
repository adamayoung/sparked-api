//
//  RemoveProfileInterest.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ProfileDomain

final class RemoveProfileInterest: RemoveProfileInterestUseCase {

    private let repository: any ProfileInterestRepository
    private let basicProfileRepository: any BasicProfileRepository

    init(
        repository: some ProfileInterestRepository,
        basicProfileRepository: some BasicProfileRepository
    ) {
        self.repository = repository
        self.basicProfileRepository = basicProfileRepository
    }

    func execute(input: RemoveProfileInterestInput) async throws(RemoveProfileInterestError) {
        let basicProfile = try await basicProfile(withID: input.profileID)
        let profileInterest = try await profileInterest(
            byInterestID: input.interestID,
            for: basicProfile.id
        )

        do {
            try await repository.delete(id: profileInterest.id)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension RemoveProfileInterest {

    private func basicProfile(
        withID id: UUID
    ) async throws(RemoveProfileInterestError) -> BasicProfile {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await basicProfileRepository.fetch(byID: id)
        } catch BasicProfileRepositoryError.notFound {
            throw .profileNotFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }

        return basicProfile
    }

    private func profileInterest(
        byInterestID interestID: Interest.ID,
        for profileID: BasicProfile.ID
    ) async throws(RemoveProfileInterestError) -> ProfileInterest {
        let profileInterest: ProfileInterest
        do {
            profileInterest = try await repository.fetch(byInterestID: interestID, for: profileID)
        } catch ProfileInterestRepositoryError.notFound {
            throw .interestNotFound(interestID: interestID)
        } catch let error {
            throw .unknown(error)
        }

        return profileInterest
    }

}
