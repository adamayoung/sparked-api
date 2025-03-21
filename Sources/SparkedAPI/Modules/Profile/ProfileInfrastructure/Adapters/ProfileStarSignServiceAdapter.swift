//
//  ProfileStarSignServiceAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import ProfileInfrastructure
import ReferenceDataApplication

final class ProfileStarSignServiceAdapter: StarSignService {

    private let fetchStarSignUseCase: any FetchStarSignUseCase

    init(fetchStarSignUseCase: some FetchStarSignUseCase) {
        self.fetchStarSignUseCase = fetchStarSignUseCase
    }

    func fetch(
        byID id: ProfileDomain.StarSign.ID
    ) async throws(StarSignServiceError) -> ProfileDomain.StarSign {
        let referenceDataStarSignDTO: ReferenceDataApplication.StarSignDTO
        do {
            referenceDataStarSignDTO = try await fetchStarSignUseCase.execute(id: id)
        } catch FetchStarSignError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        let starSign = ProfileStarSignMapper.map(from: referenceDataStarSignDTO)

        return starSign
    }

}
