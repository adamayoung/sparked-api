//
//  ProfilePhotoModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Fluent
import Foundation

final class ProfilePhotoModel: Model, @unchecked Sendable {

    static let schema = "profile_photo"

    @ID var id: UUID?

    @Field(key: "user_id")
    var userID: UUID

    @Field(key: "profile_id")
    var profileID: UUID

    @Field(key: "photo_index")
    var index: Int

    @Field(key: "filename")
    var filename: String

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
        profileID: UUID,
        index: Int,
        filename: String
    ) {
        self.id = id
        self.userID = userID
        self.profileID = profileID
        self.index = index
        self.filename = filename
    }

}
