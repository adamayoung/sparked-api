//
//  FetchInterestGroups.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchInterestGroups: FetchInterestGroupsUseCase {

    private let repository: any InterestGroupRepository
    private let interestRepository: any InterestRepository

    init(
        repository: some InterestGroupRepository,
        interestRepository: some InterestRepository
    ) {
        self.repository = repository
        self.interestRepository = interestRepository
    }

    func execute() async throws(FetchInterestGroupsError) -> [InterestGroupDTO] {
        let interestGroups = try await self.interestGroups()
            .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        let interestGroupDTOs = interestGroups.map(InterestGroupDTOMapper.map)

        return interestGroupDTOs
    }

    func executeIncludingInterests() async throws(FetchInterestGroupsError)
        -> [InterestGroupAggregateDTO]
    {
        let interestGroups = try await self.interestGroups()
        let interestsByInterestGroup = try await self.interests(for: interestGroups)
        let interestGroupAggregateDTOs =
            interestsByInterestGroup
            .map { (interestGroup, interests) in
                InterestGroupAggregateDTOMapper.map(
                    from: interestGroup,
                    interests: interests
                )
            }
            .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }

        return interestGroupAggregateDTOs
    }

}

extension FetchInterestGroups {

    private func interestGroups() async throws(FetchInterestGroupsError) -> [InterestGroup] {
        let interestGroups: [InterestGroup]
        do {
            interestGroups = try await repository.fetchAll()
        } catch let error {
            throw .unknown(error)
        }

        return interestGroups
    }

    private func interests(
        for interestGroups: [InterestGroup]
    ) async throws(FetchInterestGroupsError) -> [InterestGroup: [Interest]] {
        do {
            return try await withThrowingTaskGroup(
                of: (InterestGroup, [Interest]).self
            ) { taskGroup in
                for interestGroup in interestGroups {
                    taskGroup.addTask {
                        let interests: [Interest]
                        do {
                            interests = try await self.interestRepository.fetchAll(
                                forInterestGroupID: interestGroup.id
                            )
                        } catch let error {
                            throw FetchInterestGroupsError.unknown(error)
                        }

                        return (interestGroup, interests)
                    }
                }

                var interestsByInterestGroup: [InterestGroup: [Interest]] = [:]
                for try await (interestGroup, interests) in taskGroup {
                    interestsByInterestGroup[interestGroup] = interests.sorted(
                        by: { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
                    )
                }

                return interestsByInterestGroup
            }
        } catch let error as FetchInterestGroupsError {
            throw error
        } catch let error {
            throw .unknown(error)
        }
    }

}
