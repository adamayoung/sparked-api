//
//  GenderStaticRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataInfrastructure

@Suite
struct GenderStaticRepositoryTests {

    let repository: GenderStaticRepository

    init() {
        self.repository = GenderStaticRepository()
    }

    @Test("genders contains male")
    func gendersContainsMale() async throws {
        let maleGender = try Gender(
            id: #require(UUID(uuidString: "EBE46F14-FA26-4577-A965-31293F2168C7")),
            name: "Male"
        )

        let genders = try await self.repository.genders()

        #expect(genders.contains(maleGender))
    }

    @Test("gender contains female")
    func gendersContainsFemale() async throws {
        let femaleGender = try Gender(
            id: #require(UUID(uuidString: "F2D4C883-4225-4B82-AB95-AD169D9160BB")),
            name: "Female"
        )

        let genders = try await self.repository.genders()

        #expect(genders.contains(femaleGender))
    }

    @Test("gender contains other")
    func gendersContainsOther() async throws {
        let otherGender = try Gender(
            id: #require(UUID(uuidString: "2E1D25D0-E0FA-4A7F-99C8-962B43E25C33")),
            name: "Other"
        )

        let genders = try await self.repository.genders()

        #expect(genders.contains(otherGender))
    }

}
