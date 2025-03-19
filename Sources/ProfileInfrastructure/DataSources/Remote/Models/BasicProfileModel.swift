//
//  BasicProfileModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

final class BasicProfileModel: Model, @unchecked Sendable {

    static let schema = "basic_profile"

    @ID var id: UUID?

    @Field(key: "user_id")
    var userID: UUID

    @Field(key: "display_name")
    var displayName: String

    @Field(key: "birth_date")
    var birthDate: Date

    @Field(key: "bio")
    var bio: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() {}

    init(
        id: UUID? = nil,
        userID: UUID,
        displayName: String,
        birthDate: Date,
        bio: String
    ) {
        self.id = id
        self.userID = userID
        self.displayName = displayName
        self.birthDate = birthDate
        self.bio = bio
    }

}
