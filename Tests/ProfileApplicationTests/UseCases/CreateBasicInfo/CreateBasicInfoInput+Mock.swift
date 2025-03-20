//
//  CreateBasicInfoInput+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication
import Testing

extension CreateBasicInfoInput {

    static func mock(
        profileID: UUID? = UUID(uuidString: "3EFF438F-6F53-4C8E-B5B0-2D690DCB7B85"),
        genderID: UUID? = UUID(uuidString: "5801E71F-A4F4-450B-8F9E-5064089E533D"),
        countryID: UUID? = UUID(uuidString: "5298A411-9A18-4305-AEA5-B79F212050ED"),
        location: String = "Location",
        homeTown: String? = "Home town",
        workplace: String? = "Workplace"
    ) throws -> CreateBasicInfoInput {
        try CreateBasicInfoInput(
            profileID: #require(profileID),
            genderID: #require(genderID),
            countryID: #require(countryID),
            location: location,
            homeTown: homeTown,
            workplace: workplace
        )
    }

}
