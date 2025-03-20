//
//  BasicInfoRemoteFluentDataSourceTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Fluent
import Foundation
import ProfileApplication
import ProfileDomain
import Testing
import XCTFluent

@testable import ProfileInfrastructure

@Suite("BasicInfoRemoteFluentDataSource")
struct BasicInfoRemoteFluentDataSourceTests {

    let dataSource: BasicInfoRemoteFluentDataSource
    let database: ArrayTestDatabase

    init() {
        self.database = ArrayTestDatabase()
        self.dataSource = BasicInfoRemoteFluentDataSource(database: database.db)
    }

    @Test("fetch by profile ID when basic info exists returns basic info")
    func fetchByProfileDWhenBasicInfoExistsReturnsBasicInfo() async throws {
        let profileID = try #require(UUID(uuidString: "E3BB89B5-B51B-4410-804E-AD259C274F44"))
        let existingBasicInfo = try BasicInfoModel.mock(profileID: profileID)
        database.append([existingBasicInfo])

        let basicProfile = try await dataSource.fetch(byProfileID: profileID)

        #expect(basicProfile.profileID == profileID)
    }

    @Test("fetch by profile ID when basic info does not exists throws user not found error")
    func fetchByProfileIDWhenBasicInfoDoesNotExistsThrowsNotFoundError() async throws {
        let profileID = try #require(UUID(uuidString: "E3BB89B5-B51B-4410-804E-AD259C274F44"))
        database.append([])

        await #expect(throws: BasicInfoRepositoryError.notFound) {
            _ = try await dataSource.fetch(byProfileID: profileID)
        }
    }

}
