//
//  ExtendedInfoModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Fluent
import Foundation

final class ExtendedInfoModel: Model, @unchecked Sendable {

    static let schema = "profile_extended_info"

    @ID var id: UUID?

    @Field(key: "profile_id")
    var profileID: UUID

    @Field(key: "height")
    var height: Double?

    @Field(key: "education_level_id")
    var educationLevelID: UUID?

    @Field(key: "star_sign_id")
    var starSignID: UUID?

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
        height: Double? = nil,
        educationLevelID: UUID? = nil,
        starSignID: UUID? = nil,
        ownerID: UUID
    ) {
        self.id = id
        self.profileID = profileID
        self.height = height
        self.educationLevelID = educationLevelID
        self.starSignID = starSignID
        self.ownerID = ownerID
    }

}
