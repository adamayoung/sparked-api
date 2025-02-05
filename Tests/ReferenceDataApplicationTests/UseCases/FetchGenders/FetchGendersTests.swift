//
//  FetchGendersTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//
//
//import Foundation
//import ReferenceDataDomain
//import Testing
//
//@testable import ReferenceDataApplication
//
//@Suite("FetchGenders")
//struct FetchGendersTests {
//
//    let useCase: FetchGenders
//    let repository: FetchGendersStubRepository
//
//    init() {
//        self.repository = FetchGendersStubRepository()
//        self.useCase = FetchGenders(repository: repository)
//    }
//
//    @Test("execute returns genders")
//    func executeReturnsGenders() async throws {
//        let expectedGenders = try [
//            Gender(
//                id: #require(UUID(uuidString: "DF2E5A61-3038-4473-8698-C7AFB2E7BBBB")),
//                name: "Male"
//            ),
//            Gender(
//                id: #require(UUID(uuidString: "05A0397F-EC54-45AA-AEA9-9EC91D2E3509")),
//                name: "Female"
//            )
//        ]
//        repository.gendersResult = .success(expectedGenders)
//
//        let genders = try await useCase.execute()
//
//        #expect(genders == expectedGenders)
//        #expect(repository.gendersHasBeenCalled)
//    }
//
//    @Test("execute when fails throws error")
//    func executeWhenFailsThrowsError() async {
//        repository.gendersResult = .failure(.unknown())
//
//        await #expect(throws: FetchGendersError.unknown()) {
//            try await useCase.execute()
//        }
//    }
//
//}
