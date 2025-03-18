//
//  ProfileInterestModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Fluent
import Foundation

final class ProfileInterestModel: Model, @unchecked Sendable {

    static let schema = "profile_interest"

    @ID var id: UUID?

    @Field(key: "user_id")
    var userID: UUID

    @Field(key: "profile_id")
    var profileID: UUID

    @Field(key: "interest_id")
    var interestID: UUID

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
        interestID: UUID
    ) {
        self.id = id
        self.userID = userID
        self.profileID = profileID
        self.interestID = interestID
    }

}
