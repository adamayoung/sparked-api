//
//  StarSignRemoteDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class StarSignRemoteFluentDataSource: StarSignRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func fetchAll() async throws(StarSignRepositoryError) -> [StarSign] {
        let starSignModels: [StarSignModel]
        do {
            starSignModels = try await StarSignModel.query(on: database).all()
        } catch let error {
            throw .unknown(error)
        }

        let starSigns: [StarSign]
        do {
            starSigns = try starSignModels.map(StarSignMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return starSigns
    }

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign {
        let starSignModel: StarSignModel?
        do {
            starSignModel = try await StarSignModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let starSignModel else {
            throw .notFound
        }

        let starSign: StarSign
        do {
            starSign = try StarSignMapper.map(from: starSignModel)
        } catch let error {
            throw .unknown(error)
        }

        return starSign
    }

}
