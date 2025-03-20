//
//  EducationLevelCacheDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol EducationLevelCacheDataSource: Sendable {

    func fetchAll() async throws(EducationLevelRepositoryError) -> [EducationLevel]?

    func setEducationLevels(
        _ educationLevels: [EducationLevel]
    ) async throws(EducationLevelRepositoryError)

    func fetch(
        byID id: EducationLevel.ID
    ) async throws(EducationLevelRepositoryError) -> EducationLevel?

    func setEducationLevel(
        _ educationLevel: EducationLevel
    ) async throws(EducationLevelRepositoryError)

}
