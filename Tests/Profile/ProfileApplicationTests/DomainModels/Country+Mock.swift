//
//  Country+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import Testing

extension Country {

    static func mock(
        id: UUID? = UUID(uuidString: "698DD1A8-B827-4511-930A-C6854C6A4948"),
        code: String = "GB",
        name: String = "United Kingdom"
    ) throws -> Country {
        try Country(
            id: #require(id),
            code: code,
            name: name
        )
    }

}
