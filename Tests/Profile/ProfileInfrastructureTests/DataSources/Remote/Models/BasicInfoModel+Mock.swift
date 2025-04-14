//
//  BasicInfoModel+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileInfrastructure

extension BasicInfoModel {

    static func mock(
        id: UUID? = UUID(uuidString: "42E8A178-B848-4558-946E-BBE007527110"),
        profileID: UUID? = UUID(uuidString: "D7FD9429-780F-4094-A897-17B451AE44F9"),
        genderID: UUID? = try? Gender.maleMock().id,
        countryID: UUID? = try? Country.unitedKingdomMock().id,
        location: String = "Location",
        homeTown: String? = "Home town",
        workplace: String? = "Workplace",
        ownerID: UUID? = try? User.mock().id
    ) throws -> BasicInfoModel {
        try BasicInfoModel(
            id: id,
            profileID: #require(profileID),
            genderID: #require(genderID),
            countryID: #require(countryID),
            location: location,
            homeTown: homeTown,
            workplace: workplace,
            ownerID: #require(ownerID)
        )
    }

}
