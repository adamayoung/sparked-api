//
//  InterestModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Fluent
import Foundation

final class InterestModel: Model, @unchecked Sendable {

    static let schema = "reference_data_interest"

    @ID var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "name_key")
    var nameKey: String

    @Field(key: "glyph")
    var glyph: String

    @Parent(key: "interest_group_id")
    var interestGroup: InterestGroupModel

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
        glyph: String
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
        self.glyph = glyph
    }

}
