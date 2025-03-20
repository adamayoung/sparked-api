//
//  BasicInfo+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import Testing

extension BasicInfo {

    static func mock(
        id: UUID? = UUID(uuidString: "E0172A6A-87A9-43F4-A71F-15974EC30822"),
        profileID: UUID? = UUID(uuidString: "178B7F83-DB3C-4697-90FB-221E05B694CA"),
        genderID: UUID? = UUID(uuidString: "7EE528D5-F9BF-4D8C-8E13-0A4F3799B083"),
        countryID: UUID? = UUID(uuidString: "B0B145D3-AB7B-4260-ACE0-79CEB23A775B"),
        location: String = "Location",
        homeTown: String = "Home town",
        workplace: String = "Workplace",
        ownerID: UUID? = UUID(uuidString: "34CDAC87-07CB-4170-84B1-78B756E20650")
    ) throws -> BasicInfo {
        try BasicInfo(
            id: #require(id),
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
