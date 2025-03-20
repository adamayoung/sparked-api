//
//  StarSignModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Fluent
import Foundation

final class StarSignModel: Model, @unchecked Sendable {

    static let schema = "reference_data_star_sign"

    @ID var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "name_key")
    var nameKey: String

    @Field(key: "glyph")
    var glyph: String

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
        glyph: String,
        index: Int
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
        self.glyph = glyph
        self.index = index
    }

}
