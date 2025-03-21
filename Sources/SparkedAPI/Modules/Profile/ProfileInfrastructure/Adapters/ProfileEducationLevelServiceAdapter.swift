//
//  ProfileEducationLevelServiceAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import ProfileInfrastructure
import ReferenceDataApplication

final class ProfileEducationLevelServiceAdapter: EducationLevelService {

    private let fetchEducationLevelUseCase: any FetchEducationLevelUseCase

    init(fetchEducationLevelUseCase: some FetchEducationLevelUseCase) {
        self.fetchEducationLevelUseCase = fetchEducationLevelUseCase
    }

    func fetch(
        byID id: ProfileDomain.EducationLevel.ID
    ) async throws(EducationLevelServiceError) -> ProfileDomain.EducationLevel {
        let referenceDataEducationLevelDTO: EducationLevelDTO
        do {
            referenceDataEducationLevelDTO = try await fetchEducationLevelUseCase.execute(id: id)
        } catch FetchEducationLevelError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        let educationLevel = ProfileEducationLevelMapper.map(from: referenceDataEducationLevelDTO)

        return educationLevel
    }

}
