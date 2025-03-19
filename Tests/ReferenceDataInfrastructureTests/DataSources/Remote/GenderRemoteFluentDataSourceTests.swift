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

    @Test("fetchAll returns genders")
    func fetchAllReturnsGenders() async throws {
        let countryModels = try [
            GenderModel(
                id: #require(UUID(uuidString: "0D2ADFC7-7224-4154-9387-1C15EEB4D80F")),
                code: "M",
                name: "Male",
                nameKey: "MALE"
            ),
            GenderModel(
                id: #require(UUID(uuidString: "1B4A387B-23FC-42ED-9B7C-F32CD96A3F96")),
                code: "F",
                name: "Female",
                nameKey: "FEMALE"
            )
        ]
        let expectedGenders = try [
            Gender(
                id: #require(UUID(uuidString: "0D2ADFC7-7224-4154-9387-1C15EEB4D80F")),
                code: "M",
                name: "Male",
                nameKey: "MALE"
            ),
            Gender(
                id: #require(UUID(uuidString: "1B4A387B-23FC-42ED-9B7C-F32CD96A3F96")),
                code: "F",
                name: "Female",
                nameKey: "FEMALE"
            )
        ]
        database.append(countryModels)

        let genders = try await dataSource.fetchAll()

        #expect(genders == expectedGenders)
    }

}
