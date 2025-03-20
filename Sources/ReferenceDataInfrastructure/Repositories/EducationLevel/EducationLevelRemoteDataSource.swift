//
//  EducationLevelRemoteDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol EducationLevelRemoteDataSource: Sendable {

    func fetchAll() async throws(EducationLevelRepositoryError) -> [EducationLevel]

    func fetch(byID id: EducationLevel.ID) async throws(EducationLevelRepositoryError)
        -> EducationLevel

}
