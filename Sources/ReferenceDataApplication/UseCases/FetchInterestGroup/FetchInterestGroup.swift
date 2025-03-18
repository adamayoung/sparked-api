//
//  FetchInterestGroup.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchInterestGroup: FetchInterestGroupUseCase {

    private let repository: any InterestGroupRepository
    private let interestRepository: any InterestRepository

    init(
        repository: some InterestGroupRepository,
        interestRepository: some InterestRepository
    ) {
        self.repository = repository
        self.interestRepository = interestRepository
    }

    func execute(
        id: InterestGroupDTO.ID
    ) async throws(FetchInterestGroupError) -> InterestGroupDTO {
        let interestGroup = try await self.interestGroup(id: id)
        let interestGroupDTO = InterestGroupDTOMapper.map(from: interestGroup)

        return interestGroupDTO
    }

    func executeIncludingInterests(
        id: InterestGroupDTO.ID
    ) async throws(FetchInterestGroupError) -> InterestGroupAggregateDTO {
        let interestGroup = try await self.interestGroup(id: id)
        let interests: [Interest]
        do {
            interests = try await interestRepository.fetchAll(forInterestGroupID: id)
                .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        } catch .notFound {
            throw .notFound(interestGroupID: id)
        } catch let error {
            throw .unknown(error)
        }

        let interestGroupAggregateDTO = InterestGroupAggregateDTOMapper.map(
            from: interestGroup,
            interests: interests
        )

        return interestGroupAggregateDTO
    }

}

extension FetchInterestGroup {

    private func interestGroup(
        id: InterestGroupDTO.ID
    ) async throws(FetchInterestGroupError) -> InterestGroup {
        let interestGroup: InterestGroup
        do {
            interestGroup = try await repository.fetch(byID: id)
        } catch .notFound {
            throw .notFound(interestGroupID: id)
        } catch let error {
            throw .unknown(error)
        }

        return interestGroup
    }

}
