//
//  EducationLevelModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Fluent
import Foundation

final class EducationLevelModel: Model, @unchecked Sendable {

    static let schema = "education_level"

    @ID var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "name_key")
    var nameKey: String

    @Field(key: "index")
    var index: Int

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() {}

    init(
        id: UUID? = nil,
        name: String,
        nameKey: String,
        index: Int
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
        self.index = index
    }

}
