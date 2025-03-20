//
//  FetchEducationLevels.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchEducationLevels: FetchEducationLevelsUseCase {

    private let repository: any EducationLevelRepository

    init(repository: some EducationLevelRepository) {
        self.repository = repository
    }

    func execute() async throws(FetchEducationLevelsError) -> [EducationLevelDTO] {
        let educationLevels: [EducationLevel]
        do {
            educationLevels = try await repository.fetchAll()
        } catch let error {
            throw .unknown(error)
        }

        let educationLevelDTOs =
            educationLevels
            .sorted { $0.index < $1.index }
            .map(EducationLevelDTOMapper.map)

        return educationLevelDTOs
    }

}
