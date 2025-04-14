//
//  FetchEducationLevel.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchEducationLevel: FetchEducationLevelUseCase {

    private let repository: any EducationLevelRepository

    init(repository: some EducationLevelRepository) {
        self.repository = repository
    }

    func execute(
        id: EducationLevelDTO.ID
    ) async throws(FetchEducationLevelError) -> EducationLevelDTO {
        let educationLevel: EducationLevel
        do {
            educationLevel = try await repository.fetch(byID: id)
        } catch EducationLevelRepositoryError.notFound {
            throw .notFound(educationLevelID: id)
        } catch let error {
            throw .unknown(error)
        }

        let educationLevelDTO = EducationLevelDTOMapper.map(from: educationLevel)

        return educationLevelDTO
    }

}
