//
//  FetchInterests.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchInterests: FetchInterestsUseCase {

    private let repository: any InterestRepository

    init(repository: some InterestRepository) {
        self.repository = repository
    }

    func execute(
        interestGroupID: InterestGroupDTO.ID
    ) async throws(FetchInterestsError) -> [InterestDTO] {
        let interests: [Interest]
        do {
            interests = try await repository.fetchAll(forInterestGroupID: interestGroupID)
        } catch let error {
            throw .unknown(error)
        }

        let interestDTOs = interests.map(InterestDTOMapper.map)

        return interestDTOs
    }

}
