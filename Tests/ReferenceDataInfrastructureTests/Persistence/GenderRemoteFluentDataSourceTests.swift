//
//  GenderRemoteFluentDataSourceTests.swift
//  AdamDateApp
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

    @Test("genders returns genders")
    func gendersReturnsGenders() async throws {
        let countryModels = try [
            GenderModel(
                id: #require(UUID(uuidString: "0D2ADFC7-7224-4154-9387-1C15EEB4D80F")),
                code: "M",
                name: "Male"
            ),
            GenderModel(
                id: #require(UUID(uuidString: "1B4A387B-23FC-42ED-9B7C-F32CD96A3F96")),
                code: "F",
                name: "Female"
            )
        ]
        let expectedGenders = try [
            Gender(
                id: #require(UUID(uuidString: "0D2ADFC7-7224-4154-9387-1C15EEB4D80F")),
                code: "M",
                name: "Male"
            ),
            Gender(
                id: #require(UUID(uuidString: "1B4A387B-23FC-42ED-9B7C-F32CD96A3F96")),
                code: "F",
                name: "Female"
            )
        ]
        database.append(countryModels)

        let genders = try await dataSource.genders()

        #expect(genders == expectedGenders)
    }

}
