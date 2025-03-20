//
//  ProfilePhotoModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/03/2025.
//

import Fluent
import Foundation

final class ProfilePhotoModel: Model, @unchecked Sendable {

    static let schema = "profile_profile_photo"

    @ID var id: UUID?

    @Field(key: "profile_id")
    var profileID: UUID

    @Field(key: "photo_index")
    var index: Int

    @Field(key: "filename")
    var filename: String

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
        profileID: UUID,
        index: Int,
        filename: String,
        ownerID: UUID
    ) {
        self.id = id
        self.profileID = profileID
        self.index = index
        self.filename = filename
        self.ownerID = ownerID
    }

}
