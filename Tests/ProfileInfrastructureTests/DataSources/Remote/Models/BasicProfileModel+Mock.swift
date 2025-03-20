//
//  BasicProfileModel+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileInfrastructure

extension BasicProfileModel {

    static func mock(
        id: UUID? = UUID(uuidString: "B65AA56D-16D9-4C6F-A6A7-0E1060F20E09"),
        displayName: String = "Dave",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = "Test bio",
        ownerID: UUID? = try? User.mock().id
    ) throws -> BasicProfileModel {
        try BasicProfileModel(
            id: id,
            displayName: displayName,
            birthDate: birthDate,
            bio: bio,
            ownerID: #require(ownerID)
        )
    }

}
