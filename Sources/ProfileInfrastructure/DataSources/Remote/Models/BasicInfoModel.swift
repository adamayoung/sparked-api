//
//  BasicInfoModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Fluent
import Foundation

final class BasicInfoModel: Model, @unchecked Sendable {

    static let schema = "basic_info"

    @ID var id: UUID?

    @Field(key: "user_id")
    var userID: UUID

    @Field(key: "profile_id")
    var profileID: UUID

    @Field(key: "gender_id")
    var genderID: UUID

    @Field(key: "country_id")
    var countryID: UUID

    @Field(key: "location")
    var location: String

    @Field(key: "home_town")
    var homeTown: String?

    @Field(key: "workplace")
    var workplace: String?

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
        genderID: UUID,
        countryID: UUID,
        location: String,
        homeTown: String? = nil,
        workplace: String? = nil
    ) {
        self.id = id
        self.userID = userID
        self.profileID = profileID
        self.genderID = genderID
        self.countryID = countryID
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
    }

}
