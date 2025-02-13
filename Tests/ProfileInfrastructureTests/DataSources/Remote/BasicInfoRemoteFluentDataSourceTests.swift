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
        let existingBasicInfo = try BasicInfoModel(
            id: #require(UUID(uuidString: "42E8A178-B848-4558-946E-BBE007527110")),
            userID: #require(UUID(uuidString: "34CDAC87-07CB-4170-84B1-78B756E20650")),
            profileID: profileID,
            genderID: #require(UUID(uuidString: "E9E02AB7-0E8F-40C9-86DA-03311E49D854")),
            countryID: #require(UUID(uuidString: "6C2717F2-6F7A-4068-989D-413A4DAC859A")),
            location: "Location",
            homeTown: "Home town",
            workplace: "Workplace"
        )
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
