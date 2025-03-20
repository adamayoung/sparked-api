//
//  CreateBasicProfileInput+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication
import Testing

extension CreateBasicProfileInput {

    static func mock(
        userID: UUID? = UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"),
        displayName: String = "Dave Smith",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = ""
    ) throws -> CreateBasicProfileInput {
        try CreateBasicProfileInput(
            displayName: displayName,
            birthDate: birthDate,
            bio: bio,
            ownerID: #require(userID)
        )
    }

}
