//
//  EducationLevelDefaultRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class EducationLevelDefaultRepository: EducationLevelRepository {

    private let educationLevelService: any EducationLevelService

    init(educationLevelService: some EducationLevelService) {
        self.educationLevelService = educationLevelService
    }

    func fetch(
        byID id: EducationLevel.ID
    ) async throws(EducationLevelRepositoryError) -> EducationLevel {
        let educationLevel: EducationLevel
        do {
            educationLevel = try await educationLevelService.fetch(byID: id)
        } catch EducationLevelServiceError.notFound {
            throw .notFound
        } catch let error {
            throw .unknown(error)
        }

        return educationLevel
    }

}
