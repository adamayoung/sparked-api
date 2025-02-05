//
//  FetchCountriesTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//
//
//import Foundation
//import Testing
//
//@testable import ReferenceDataApplication
//
//@Suite
//struct FetchCountriesTests {
//
//    let useCase: FetchCountries
//    let repository: FetchCountriesStubRepository
//
//    init() {
//        self.repository = FetchCountriesStubRepository()
//        self.useCase = FetchCountries(repository: repository)
//    }
//
//    @Test("execute returns countries")
//    func executeReturnsCountries() async throws {
//        let expectedCountries: [CountryDTO.ID: CountryDTO] = [
//            "GB": CountryDTO(id: "GB", name: "United Kingdom"),
//            "US": CountryDTO(id: "US", name: "United States")
//        ]
//        repository.countriesResult = .success(expectedCountries)
//
//        let countries = try await useCase.execute()
//
//        #expect(countries == expectedCountries)
//        #expect(repository.countriesWasCalled)
//    }
//
//    @Test("execute when fails throws error")
//    func executeWhenFailsThrowsError() async {
//        repository.countriesResult = .failure(.unknown())
//
//        await #expect(throws: FetchCountriesError.unknown()) {
//            try await useCase.execute()
//        }
//    }
//
//}
