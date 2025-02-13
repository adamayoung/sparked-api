//
//  BasicInfoMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import Testing

@testable import ProfileInfrastructure

@Suite("BasicInfoMapper")
struct BasicInfoMapperTests {

    @Test("map from basic info model with ID")
    func mapFromBasicInfoModelWithID() throws {
        let id = try #require(UUID(uuidString: "273AE8EC-E079-4BF6-812C-98868E99CCE2"))
        let basicInfoModel = try Self.buildBasicInfoModel(id: id)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.id == id)
    }

    @Test("map from basic info model when ID is nil throws error")
    func mapFromBasicInfoModelWhenIDIsNilThrowsError() throws {
        let basicInfoModel = try Self.buildBasicInfoModel(id: nil)

        #expect(throws: Error.self) {
            _ = try BasicInfoMapper.map(from: basicInfoModel)
        }
    }

    @Test("map from basic info model with profileID")
    func mapFromBasicInfoModelWithProfileID() throws {
        let profileID = try #require(UUID(uuidString: "8DD72742-BE77-4217-982F-6946C02B8B43"))
        let basicInfoModel = try Self.buildBasicInfoModel(profileID: profileID)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.profileID == profileID)
    }

    @Test("map from basic info model with genderID")
    func mapFromBasicInfoModelWithGenderID() throws {
        let genderID = try #require(UUID(uuidString: "632F0172-5107-4E04-810F-FD31CEA330D6"))
        let basicInfoModel = try Self.buildBasicInfoModel(genderID: genderID)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.genderID == genderID)
    }

    @Test("map from basic info model with countryID")
    func mapFromBasicInfoModelWithCountryID() throws {
        let countryID = try #require(UUID(uuidString: "64608D33-0CEF-4A79-BD14-4FDE56A33199"))
        let basicInfoModel = try Self.buildBasicInfoModel(countryID: countryID)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.countryID == countryID)
    }

    @Test("map from basic info model with location")
    func mapFromBasicInfoModelWithLocation() throws {
        let location = "Gloucester"
        let basicInfoModel = try Self.buildBasicInfoModel(location: location)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.location == location)
    }

    @Test("map from basic info model with homeTown")
    func mapFromBasicInfoModelWithHomeTown() throws {
        let homeTown = "Birmingham"
        let basicInfoModel = try Self.buildBasicInfoModel(homeTown: homeTown)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.homeTown == homeTown)
    }

    @Test("map from basic info model with nil homeTown")
    func mapFromBasicInfoModelWithNilHomeTown() throws {
        let basicInfoModel = try Self.buildBasicInfoModel(homeTown: nil)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.homeTown == nil)
    }

    @Test("map from basic info model with wokrplace")
    func mapFromBasicInfoModelWithWorkplace() throws {
        let workplace = "Microsoft"
        let basicInfoModel = try Self.buildBasicInfoModel(workplace: workplace)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.workplace == workplace)
    }

    @Test("map from basic info model with nil wokrplace")
    func mapFromBasicInfoModelWithNilWorkplace() throws {
        let basicInfoModel = try Self.buildBasicInfoModel(workplace: nil)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.workplace == nil)
    }

}

extension BasicInfoMapperTests {

    private static func buildBasicInfoModel(
        id: UUID? = UUID(uuidString: "93FD4854-A4D6-4704-9A65-F43BEDB881D6"),
        userID: UUID? = UUID(uuidString: "E5DD4113-B75D-422B-BA88-1781E0A0858E"),
        profileID: UUID? = UUID(uuidString: "6EAF94E9-3430-4073-95AB-9B3FB8883313"),
        genderID: UUID? = UUID(uuidString: "59FDAF42-06A1-4966-926F-8F736E851D3C"),
        countryID: UUID? = UUID(uuidString: "9D7BEB42-E51F-456C-9BE9-3584D84CD63C"),
        location: String = "Nottingham",
        homeTown: String? = "Leicester",
        workplace: String? = "Apple"
    ) throws -> BasicInfoModel {
        try BasicInfoModel(
            id: id,
            userID: #require(userID),
            profileID: #require(profileID),
            genderID: #require(genderID),
            countryID: #require(countryID),
            location: location,
            homeTown: homeTown,
            workplace: workplace
        )
    }

}
