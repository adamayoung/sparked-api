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

package final class GenderRemoteFluentDataSource: GenderRemoteDataSource {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    package func genders() async throws(FetchGendersError) -> [Gender] {
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

}
