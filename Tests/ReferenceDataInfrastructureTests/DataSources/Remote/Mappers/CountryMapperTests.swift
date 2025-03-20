//
//  CountryMapperTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataInfrastructure

@Suite("CountryMapper")
struct CountryMapperTests {

    @Test("map from country with ID")
    func mapFromCountryWithID() throws {
        let id = try #require(UUID(uuidString: "31037F6F-5F5B-45DB-B682-7FA6A4373BC9"))
        let model = CountryModel.mock(id: id)

        let country = try CountryMapper.map(from: model)

        #expect(country.id == id)
    }

    @Test("map from country with code")
    func mapFromCountryWithCode() throws {
        let code = "GB"
        let model = CountryModel.mock(code: code)

        let country = try CountryMapper.map(from: model)

        #expect(country.code == code)
    }

    @Test("map from country with name")
    func mapFromCountryWithName() throws {
        let name = "United Kingdom"
        let model = CountryModel.mock(name: name)

        let country = try CountryMapper.map(from: model)

        #expect(country.name == name)
    }

}
