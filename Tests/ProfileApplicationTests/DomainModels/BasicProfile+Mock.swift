//
//  BasicProfile+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import Testing

extension BasicProfile {

    static func mock(
        id: UUID? = UUID(uuidString: "7E0C3AA0-8E76-4610-BF28-607FA97E2B9C"),
        displayName: String = "Dave",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = "Bio",
        ownerID: UUID? = UUID(uuidString: "2655470E-EB08-4E84-A3AE-CA676C8CC786")
    ) throws -> BasicProfile {
        try BasicProfile(
            id: #require(id),
            displayName: displayName,
            birthDate: birthDate,
            bio: bio,
            ownerID: #require(ownerID)
        )
    }

}
