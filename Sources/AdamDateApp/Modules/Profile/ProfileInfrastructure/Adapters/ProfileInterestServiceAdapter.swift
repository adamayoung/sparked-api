//
//  ProfileInterestServiceAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain
import ProfileInfrastructure
import ReferenceDataApplication

final class ProfileInterestServiceAdapter: InterestService {

    private let fetchInterestUseCase: any FetchInterestUseCase

    init(fetchInterestUseCase: some FetchInterestUseCase) {
        self.fetchInterestUseCase = fetchInterestUseCase
    }

    func fetch(
        byID id: ProfileDomain.Interest.ID
    ) async throws(InterestServiceError) -> ProfileDomain.Interest {
        let referenceDataInterestDTO: ReferenceDataApplication.InterestDTO
        do {
            referenceDataInterestDTO = try await fetchInterestUseCase.execute(id: id)
        } catch FetchInterestError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        let interest = ProfileInterestMapper.map(from: referenceDataInterestDTO)

        return interest
    }

}
