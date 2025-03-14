//
//  FetchInterest.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchInterest: FetchInterestUseCase {

    private let repository: any InterestRepository

    init(repository: some InterestRepository) {
        self.repository = repository
    }

    func execute(id: InterestDTO.ID) async throws(FetchInterestError) -> InterestDTO {
        let interest: Interest
        do {
            interest = try await repository.fetch(byID: id)
        } catch .notFound {
            throw .notFound(interestID: id)
        } catch let error {
            throw .unknown(error)
        }

        let interestDTO = InterestDTOMapper.map(from: interest)

        return interestDTO
    }

}
