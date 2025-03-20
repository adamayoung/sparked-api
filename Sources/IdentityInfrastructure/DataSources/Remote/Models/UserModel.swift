//
//  UserModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

final class UserModel: Model, @unchecked Sendable {

    static let schema = "identity_user"

    @ID var id: UUID?

    @Field(key: "first_name")
    var firstName: String

    @Field(key: "family_name")
    var familyName: String

    @Field(key: "email")
    var email: String

    @Field(key: "password")
    var password: String

    @Field(key: "is_verified")
    var isVerified: Bool

    @Siblings(through: UserRoleModel.self, from: \.$user, to: \.$role)
    var roles: [RoleModel]

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() {}

    init(
        id: UUID? = nil,
        firstName: String,
        familyName: String,
        email: String,
        password: String,
        isVerified: Bool
    ) {
        self.id = id
        self.firstName = firstName
        self.familyName = familyName
        self.email = email
        self.password = password
        self.isVerified = isVerified
    }

}
