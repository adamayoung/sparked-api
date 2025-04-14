//
//  CountryModel+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

@testable import ReferenceDataInfrastructure

extension CountryModel {

    static func mock(
        id: UUID? = UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900"),
        code: String = "GB",
        name: String = "United Kingdom",
        nameKey: String = "UNITED_KINGDOM"
    ) -> CountryModel {
        CountryModel(
            id: id,
            code: code,
            name: name,
            nameKey: nameKey
        )
    }

    static func unitedKingdomMock(
        id: UUID? = UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")
    ) -> CountryModel {
        Self.mock(
            id: id,
            code: "GB",
            name: "United Kingdom",
            nameKey: "UNITED_KINGDOM"
        )
    }

    static func unitedStatesMock(
        id: UUID? = UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")
    ) -> CountryModel {
        Self.mock(
            id: id,
            code: "US",
            name: "United States",
            nameKey: "UNITED_STATES"
        )
    }

}
