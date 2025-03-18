//
//  FetchProfileInterests.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

final class FetchProfileInterests: FetchProfileInterestsUseCase {

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

    func execute(profileID: UUID) async throws(FetchProfileInterestsError) -> [ProfileInterestDTO] {
        do {
            _ = try await basicProfileRepository.fetch(byID: profileID)
        } catch BasicProfileRepositoryError.notFound {
            throw .profileNotFound(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        let profileInterests: [ProfileInterest]
        do {
            profileInterests = try await repository.fetchAll(forProfileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        let interestIDs = profileInterests.map(\.interestID)
        let interestMap = try await interests(withIDs: interestIDs)

        let profileInterestDTOs =
            profileInterests
            .compactMap { profileInterest -> ProfileInterestDTO? in
                guard let interest = interestMap[profileInterest.interestID] else {
                    return nil
                }

                return ProfileInterestDTOMapper.map(from: profileInterest, interest: interest)
            }
            .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }

        return profileInterestDTOs
    }

}

extension FetchProfileInterests {

    private func interests(
        withIDs ids: [Interest.ID]
    ) async throws(FetchProfileInterestsError) -> [Interest.ID: Interest] {
        var interests: [Interest.ID: Interest] = [:]
        for id in ids {
            let interest: Interest
            do {
                interest = try await interestRepository.fetch(byID: id)
            } catch let error {
                throw .unknown(error)
            }

            interests[interest.id] = interest
        }

        return interests
    }

}
