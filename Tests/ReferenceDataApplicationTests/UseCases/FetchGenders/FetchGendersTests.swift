//
//  FetchGendersTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataApplication

@Suite("FetchGenders")
struct FetchGendersTests {

    let useCase: FetchGenders
    let repository: GenderStubRepository

    init() {
        self.repository = GenderStubRepository()
        self.useCase = FetchGenders(repository: repository)
    }

    @Test("execute returns sorted genders")
    func executeReturnsGenders() async throws {
        let genders = try [
            Gender(
                id: #require(UUID(uuidString: "DF2E5A61-3038-4473-8698-C7AFB2E7BBBB")),
                code: "M",
                name: "Male"
            ),
            Gender(
                id: #require(UUID(uuidString: "05A0397F-EC54-45AA-AEA9-9EC91D2E3509")),
                code: "F",
                name: "Female"
            )
        ]
        let expectedGenderDTOs = try [
            GenderDTO(
                id: #require(UUID(uuidString: "05A0397F-EC54-45AA-AEA9-9EC91D2E3509")),
                code: "F",
                name: "Female"
            ),
            GenderDTO(
                id: #require(UUID(uuidString: "DF2E5A61-3038-4473-8698-C7AFB2E7BBBB")),
                code: "M",
                name: "Male"
            )
        ]
        repository.fetchAllResult = .success(genders)

        let genderDTOs = try await useCase.execute()

        #expect(genderDTOs == expectedGenderDTOs)
        #expect(repository.fetchAllWasCalled)
    }

    @Test("execute when fails throws error")
    func executeWhenFailsThrowsError() async {
        repository.fetchAllResult = .failure(.unknown())

        await #expect(throws: FetchGendersError.unknown(GenderRepositoryError.unknown())) {
            try await useCase.execute()
        }
        #expect(repository.fetchAllWasCalled)
    }

}
