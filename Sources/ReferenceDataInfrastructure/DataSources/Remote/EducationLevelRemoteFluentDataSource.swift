//
//  EducationLevelRemoteFluentDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class EducationLevelRemoteFluentDataSource: EducationLevelRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func fetchAll() async throws(EducationLevelRepositoryError) -> [EducationLevel] {
        let educationLevelModels: [EducationLevelModel]
        do {
            educationLevelModels = try await EducationLevelModel.query(on: database).all()
        } catch let error {
            throw .unknown(error)
        }

        let educationLevels: [EducationLevel]
        do {
            educationLevels = try educationLevelModels.map(EducationLevelMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return educationLevels
    }

    func fetch(byID id: EducationLevel.ID) async throws(EducationLevelRepositoryError)
        -> EducationLevel
    {
        let educationLevelModel: EducationLevelModel?
        do {
            educationLevelModel = try await EducationLevelModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let educationLevelModel else {
            throw .notFound
        }

        let educationLevel: EducationLevel
        do {
            educationLevel = try EducationLevelMapper.map(from: educationLevelModel)
        } catch let error {
            throw .unknown(error)
        }

        return educationLevel
    }

}
