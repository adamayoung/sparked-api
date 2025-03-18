//
//  AddProfileInterest.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

final class AddProfileInterest: AddProfileInterestUseCase {

    private let repository: any ProfileInterestRepository
    private let interestRepository: any InterestRepository
    private let basicProfileRepository: any BasicProfileRepository

    init(
        repository: some ProfileInterestRepository,
        interestRepository: some InterestRepository,
        basicProfileRepository: some BasicProfileRepository
    ) {
        self.repository = repository
        self.interestRepository = interestRepository
        self.basicProfileRepository = basicProfileRepository
    }

    func execute(
        input: AddProfileInterestInput
    ) async throws(AddProfileInterestError) -> ProfileInterestDTO {
        if try await hasAlreadyAddedInterest(input.interestID, toProfileWithID: input.profileID) {
            throw .duplicateInterest(interestID: input.interestID)
        }

        let basicProfile = try await basicProfile(withID: input.profileID)
        let currentInterestGroupCount = try await interestGroupCount(forProfileID: basicProfile.id)
        guard currentInterestGroupCount < InterestConfiguration.maxCount else {
            throw .tooManyInterests(maxCount: InterestConfiguration.maxCount)
        }

        let interest = try await interest(withID: input.interestID)

        let profileInterestID = UUID()
        let profileInterest = ProfileInterest(
            id: profileInterestID,
            userID: basicProfile.userID,
            profileID: basicProfile.id,
            interestID: interest.id
        )

        do {
            try await repository.create(profileInterest)
        } catch let error {
            throw .unknown(error)
        }

        let profileInterestDTO = ProfileInterestDTOMapper.map(
            from: profileInterest,
            interest: interest
        )

        return profileInterestDTO
    }

}

extension AddProfileInterest {

    private func basicProfile(
        withID id: UUID
    ) async throws(AddProfileInterestError) -> BasicProfile {
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

    private func interest(
        withID id: Interest.ID
    ) async throws(AddProfileInterestError) -> Interest {
        let interest: Interest
        do {
            interest = try await interestRepository.fetch(byID: id)
        } catch InterestRepositoryError.notFound {
            throw .interestNotFound(interestID: id)
        } catch let error {
            throw .unknown(error)
        }

        return interest
    }

    private func interestGroupCount(
        forProfileID profileID: BasicProfile.ID
    ) async throws(AddProfileInterestError) -> Int {
        let interestGroupsCount: Int
        do {
            interestGroupsCount = try await repository.fetchAll(forProfileID: profileID).count
        } catch let error {
            throw .unknown(error)
        }

        return interestGroupsCount
    }

    private func hasAlreadyAddedInterest(
        _ interestID: Interest.ID,
        toProfileWithID profileID: UUID
    ) async throws(AddProfileInterestError) -> Bool {
        do {
            _ = try await repository.fetch(byInterestID: interestID, for: profileID)
        } catch ProfileInterestRepositoryError.notFound {
            return false
        } catch let error {
            throw .unknown(error)
        }

        return true
    }

}
