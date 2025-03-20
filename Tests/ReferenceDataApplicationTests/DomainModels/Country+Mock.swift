//
//  Country+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ReferenceDataDomain
import Testing

extension Country {

    static func mock(
        id: UUID? = UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900"),
        code: String = "GB",
        name: String = "United Kingdom",
        nameKey: String = "UNITED_KINGDOM"
    ) throws -> Country {
        try Country(
            id: #require(id),
            code: code,
            name: name,
            nameKey: nameKey
        )
    }

    static func unitedKingdomMock(
        id: UUID? = UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")
    ) throws -> Country {
        try Self.mock(
            id: id,
            code: "GB",
            name: "United Kingdom",
            nameKey: "UNITED_KINGDOM"
        )
    }

    static func unitedStatesMock(
        id: UUID? = UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")
    ) throws -> Country {
        try Self.mock(
            id: id,
            code: "US",
            name: "United States",
            nameKey: "UNITED_STATES"
        )
    }

}
