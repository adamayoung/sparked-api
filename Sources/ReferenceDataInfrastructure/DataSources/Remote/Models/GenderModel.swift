//
//  GenderModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

final class GenderModel: Model, @unchecked Sendable {

    static let schema = "reference_data_gender"

    @ID var id: UUID?

    @Field(key: "code")
    var code: String

    @Field(key: "name")
    var name: String

    @Field(key: "name_key")
    var nameKey: String

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
        name: String,
        nameKey: String
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.nameKey = nameKey
    }

}
