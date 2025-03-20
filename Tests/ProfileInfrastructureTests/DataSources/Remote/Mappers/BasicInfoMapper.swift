//
//  BasicInfoMapper.swift
//  SparkedAPI
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
        let basicInfoModel = try BasicInfoModel.mock(id: id)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.id == id)
    }

    @Test("map from basic info model when ID is nil throws error")
    func mapFromBasicInfoModelWhenIDIsNilThrowsError() throws {
        let basicInfoModel = try BasicInfoModel.mock(id: nil)

        #expect(throws: Error.self) {
            _ = try BasicInfoMapper.map(from: basicInfoModel)
        }
    }

    @Test("map from basic info model with profileID")
    func mapFromBasicInfoModelWithProfileID() throws {
        let profileID = try #require(UUID(uuidString: "8DD72742-BE77-4217-982F-6946C02B8B43"))
        let basicInfoModel = try BasicInfoModel.mock(profileID: profileID)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.profileID == profileID)
    }

    @Test("map from basic info model with genderID")
    func mapFromBasicInfoModelWithGenderID() throws {
        let genderID = try #require(UUID(uuidString: "632F0172-5107-4E04-810F-FD31CEA330D6"))
        let basicInfoModel = try BasicInfoModel.mock(genderID: genderID)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.genderID == genderID)
    }

    @Test("map from basic info model with countryID")
    func mapFromBasicInfoModelWithCountryID() throws {
        let countryID = try #require(UUID(uuidString: "64608D33-0CEF-4A79-BD14-4FDE56A33199"))
        let basicInfoModel = try BasicInfoModel.mock(countryID: countryID)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.countryID == countryID)
    }

    @Test("map from basic info model with location")
    func mapFromBasicInfoModelWithLocation() throws {
        let location = "Gloucester"
        let basicInfoModel = try BasicInfoModel.mock(location: location)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.location == location)
    }

    @Test("map from basic info model with homeTown")
    func mapFromBasicInfoModelWithHomeTown() throws {
        let homeTown = "Birmingham"
        let basicInfoModel = try BasicInfoModel.mock(homeTown: homeTown)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.homeTown == homeTown)
    }

    @Test("map from basic info model with nil homeTown")
    func mapFromBasicInfoModelWithNilHomeTown() throws {
        let basicInfoModel = try BasicInfoModel.mock(homeTown: nil)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.homeTown == nil)
    }

    @Test("map from basic info model with wokrplace")
    func mapFromBasicInfoModelWithWorkplace() throws {
        let workplace = "Microsoft"
        let basicInfoModel = try BasicInfoModel.mock(workplace: workplace)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.workplace == workplace)
    }

    @Test("map from basic info model with nil wokrplace")
    func mapFromBasicInfoModelWithNilWorkplace() throws {
        let basicInfoModel = try BasicInfoModel.mock(workplace: nil)

        let basicModel = try BasicInfoMapper.map(from: basicInfoModel)

        #expect(basicModel.workplace == nil)
    }

}
