//
//  GenderModel+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

@testable import ReferenceDataInfrastructure

extension GenderModel {

    static func mock(
        id: UUID? = UUID(uuidString: "D44BB085-3A86-48C5-BDC1-B333405DDCF4"),
        code: String = "M",
        name: String = "Male",
        nameKey: String = "MALE"
    ) -> GenderModel {
        GenderModel(
            id: id,
            code: code,
            name: name,
            nameKey: nameKey
        )
    }

    static func maleMock(
        id: UUID? = UUID(uuidString: "D44BB085-3A86-48C5-BDC1-B333405DDCF4")
    ) -> GenderModel {
        Self.mock(
            id: id,
            code: "M",
            name: "Male",
            nameKey: "MALE"
        )
    }

    static func femaleMock(
        id: UUID? = UUID(uuidString: "6561EAE6-E95B-4345-AB40-8EAAC31753B1")
    ) -> GenderModel {
        Self.mock(
            id: id,
            code: "F",
            name: "Female",
            nameKey: "FEMALE"
        )
    }

}
