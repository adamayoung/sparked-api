//
//  CountryModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

final class CountryModel: Model, @unchecked Sendable {

    static let schema = "country"

    @ID var id: UUID?

    @Field(key: "code")
    var code: String

    @Field(key: "name")
    var name: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() {}

    init(
        id: UUID? = nil,
        code: String,
        name: String
    ) {
        self.id = id
        self.code = code
        self.name = name
    }

}
