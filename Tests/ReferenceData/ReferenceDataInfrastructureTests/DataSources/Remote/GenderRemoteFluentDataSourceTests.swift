//
//  GenderRemoteFluentDataSourceTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import Testing
import XCTFluent

@testable import ReferenceDataInfrastructure

@Suite("GenderRemoteFluentDataSource")
struct GenderRemoteFluentDataSourceTests {

    let dataSource: GenderRemoteFluentDataSource
    let database: ArrayTestDatabase

    init() {
        self.database = ArrayTestDatabase()
        self.dataSource = GenderRemoteFluentDataSource(database: database.db)
    }

    @Test("fetchAll returns genders")
    func fetchAllReturnsGenders() async throws {
        let genderModels: [GenderModel] = [.maleMock(), .femaleMock()]
        let expectedGenders: [Gender] = try [.maleMock(), .femaleMock()]
        database.append(genderModels)

        let genders = try await dataSource.fetchAll()

        #expect(genders == expectedGenders)
    }

}
