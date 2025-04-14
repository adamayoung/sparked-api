//
//  Gender+Mock.swift
//  SparkedAPI
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

    static func maleMock(
        id: UUID? = UUID(uuidString: "D44BB085-3A86-48C5-BDC1-B333405DDCF4")
    ) throws -> Gender {
        try Self.mock(
            id: id,
            code: "M",
            name: "Male"
        )
    }

    static func femaleMock(
        id: UUID? = UUID(uuidString: "6561EAE6-E95B-4345-AB40-8EAAC31753B1")
    ) throws -> Gender {
        try Self.mock(
            id: id,
            code: "F",
            name: "Female"
        )
    }

}
