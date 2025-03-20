//
//  GenderDTO+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

extension GenderDTO {

    static func mock(
        id: UUID? = UUID(uuidString: "D44BB085-3A86-48C5-BDC1-B333405DDCF4"),
        code: String = "M",
        name: String = "Male",
        nameKey: String = "MALE"
    ) throws -> GenderDTO {
        try GenderDTO(
            id: #require(id),
            code: code,
            name: name,
            nameKey: nameKey
        )
    }

    static func maleMock(
        id: UUID? = UUID(uuidString: "D44BB085-3A86-48C5-BDC1-B333405DDCF4")
    ) throws -> GenderDTO {
        try Self.mock(
            id: id,
            code: "M",
            name: "Male",
            nameKey: "MALE"
        )
    }

    static func femaleMock(
        id: UUID? = UUID(uuidString: "6561EAE6-E95B-4345-AB40-8EAAC31753B1")
    ) throws -> GenderDTO {
        try Self.mock(
            id: id,
            code: "F",
            name: "Female",
            nameKey: "FEMALE"
        )
    }

}
