//
//  BasicProfileModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

final class BasicProfileModel: Model, @unchecked Sendable {

    static let schema = "profile_basic_profile"

    @ID var id: UUID?

    @Field(key: "display_name")
    var displayName: String

    @Field(key: "birth_date")
    var birthDate: Date

    @Field(key: "bio")
    var bio: String

    @Field(key: "owner_id")
    var ownerID: UUID

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() {}

    init(
        id: UUID? = nil,
        displayName: String,
        birthDate: Date,
        bio: String,
        ownerID: UUID
    ) {
        self.id = id
        self.displayName = displayName
        self.birthDate = birthDate
        self.bio = bio
        self.ownerID = ownerID
    }

}
