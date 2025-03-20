//
//  Gender+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import Testing

extension Gender {

    static func mock(
        id: UUID? = UUID(uuidString: "D4906FA3-CDA1-4F0B-9631-809314451110"),
        code: String = "M",
        name: String = "Male"
    ) throws -> Gender {
        try Gender(
            id: #require(id),
            code: code,
            name: name
        )
    }

}
