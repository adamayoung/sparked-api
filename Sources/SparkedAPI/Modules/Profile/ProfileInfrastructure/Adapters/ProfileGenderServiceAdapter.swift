//
//  ProfileGenderServiceAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileDomain
import ProfileInfrastructure
import ReferenceDataApplication

final class ProfileGenderServiceAdapter: GenderService {

    private let fetchGenderUseCase: any FetchGenderUseCase

    init(fetchGenderUseCase: some FetchGenderUseCase) {
        self.fetchGenderUseCase = fetchGenderUseCase
    }

    func fetch(
        byID id: ProfileDomain.Gender.ID
    ) async throws(GenderServiceError) -> ProfileDomain.Gender {
        let referenceDataGenderDTO: ReferenceDataApplication.GenderDTO
        do {
            referenceDataGenderDTO = try await fetchGenderUseCase.execute(id: id)
        } catch FetchGenderError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        let gender = ProfileGenderMapper.map(from: referenceDataGenderDTO)

        return gender
    }

}
