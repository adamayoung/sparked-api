//
//  User.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import Testing

extension User {

    static func mock(
        id: UUID? = UUID(uuidString: "70083D75-83F5-4FF0-8425-14E4C220E383"),
        email: String = "some@email.com"
    ) throws -> User {
        try User(
            id: #require(id),
            email: email
        )
    }

}
