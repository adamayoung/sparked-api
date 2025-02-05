//
//  GenderStaticRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

//import Foundation
//import ReferenceDataApplication
//import Testing
//
//@testable import ReferenceDataInfrastructure
//
//@Suite
//struct GenderStaticRepositoryTests {
//
//    let repository: GenderStaticRepository
//
//    init() {
//        self.repository = GenderStaticRepository()
//    }
//
//    @Test("genders contains male")
//    func gendersContainsMale() async throws {
//        let maleGenderDTO = try GenderDTO(
//            id: #require(UUID(uuidString: "EBE46F14-FA26-4577-A965-31293F2168C7")),
//            name: "Male"
//        )
//
//        let genderDTOs = try await self.repository.genders()
//
//        #expect(genderDTOs.contains(maleGenderDTO))
//    }
//
//    @Test("gender contains female")
//    func gendersContainsFemale() async throws {
//        let femaleGenderDTO = try GenderDTO(
//            id: #require(UUID(uuidString: "F2D4C883-4225-4B82-AB95-AD169D9160BB")),
//            name: "Female"
//        )
//
//        let genderDTOs = try await self.repository.genders()
//
//        #expect(genderDTOs.contains(femaleGenderDTO))
//    }
//
//    @Test("gender contains other")
//    func gendersContainsOther() async throws {
//        let otherGenderDTO = try GenderDTO(
//            id: #require(UUID(uuidString: "2E1D25D0-E0FA-4A7F-99C8-962B43E25C33")),
//            name: "Other"
//        )
//
//        let genderDTOs = try await self.repository.genders()
//
//        #expect(genderDTOs.contains(otherGenderDTO))
//    }
//
//}
