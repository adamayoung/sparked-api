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

    static func unitedKingdomMock(
        id: UUID? = UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")
    ) throws -> Country {
        try Self.mock(
            id: id,
            code: "GB",
            name: "United Kingdom"
        )
    }

    static func unitedStatesMock(
        id: UUID? = UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")
    ) throws -> Country {
        try Self.mock(
            id: id,
            code: "US",
            name: "United States"
        )
    }

}
