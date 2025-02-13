//
//  GenderRemoteFluentDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class GenderRemoteFluentDataSource: GenderRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func fetchAll() async throws(FetchGendersError) -> [Gender] {
        let genderModels: [GenderModel]
        do {
            genderModels = try await GenderModel.query(on: database).all()
        } catch let error {
            throw .unknown(error)
        }

        let genders: [Gender]
        do {
            genders = try genderModels.map(GenderMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return genders
    }

    func fetch(byID id: Gender.ID) async throws(FetchGenderError) -> Gender {
        let genderModel: GenderModel?
        do {
            genderModel = try await GenderModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let genderModel else {
            throw .notFound(genderID: id)
        }

        let gender: Gender
        do {
            gender = try GenderMapper.map(from: genderModel)
        } catch let error {
            throw .unknown(error)
        }

        return gender
    }

}
