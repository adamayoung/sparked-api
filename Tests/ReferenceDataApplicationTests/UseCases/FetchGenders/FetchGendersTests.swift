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
        let genders: [Gender] = try [.maleMock(), .femaleMock()]
        let expectedGenderDTOs: [GenderDTO] = try [.femaleMock(), .maleMock()]

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
