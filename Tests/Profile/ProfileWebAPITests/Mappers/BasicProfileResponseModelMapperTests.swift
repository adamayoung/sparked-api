//
//  BasicProfileDTOMapperTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication
import Testing

@testable import ProfileWebAPI

@Suite("BasicProfileResponseModelMapper")
struct BasicProfileResponseModelMapperTests {

    @Test("map from model with ID")
    func mapFromModelWithID() throws {
        let id = try #require(UUID(uuidString: "133E1176-F1BF-48D9-9515-6FEDBBC4B290"))
        let dto = try Self.buildBasicProfileDTO(id: id)

        let responseModel = BasicProfileResponseModelMapper.map(from: dto)

        #expect(responseModel.id == id)
    }

    @Test("map from model with display name")
    func mapFromModelWithDisplayName() throws {
        let displayName = "Dave"
        let dto = try Self.buildBasicProfileDTO(displayName: displayName)

        let responseModel = BasicProfileResponseModelMapper.map(from: dto)

        #expect(responseModel.displayName == displayName)
    }

}

extension BasicProfileResponseModelMapperTests {

    private static func buildBasicProfileDTO(
        id: UUID? = UUID(uuidString: "A1F167AD-6FEC-4A48-8A55-775D2A645FB0"),
        displayName: String = "",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        age: Int = 21,
        bio: String = ""
    ) throws -> BasicProfileDTO {
        try BasicProfileDTO(
            id: #require(id),
            displayName: displayName,
            birthDate: birthDate,
            age: age,
            bio: bio
        )
    }

}
