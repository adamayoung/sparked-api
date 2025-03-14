//
//  InterestGroupModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Fluent
import Foundation

final class InterestGroupModel: Model, @unchecked Sendable {

    static let schema = "interest_group"

    @ID var id: UUID?

    @Field(key: "name")
    var name: String

    @Children(for: \.$interestGroup)
    var interests: [InterestModel]

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() {}

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }

}
