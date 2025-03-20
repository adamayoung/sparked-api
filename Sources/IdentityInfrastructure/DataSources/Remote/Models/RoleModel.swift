//
//  UserRoleModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Fluent
import Foundation

final class RoleModel: Model, @unchecked Sendable {

    static let schema = "identity_role"

    @ID var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "code")
    var code: String

    @Field(key: "description")
    var description: String

    @Siblings(through: UserRoleModel.self, from: \.$role, to: \.$user)
    var users: [UserModel]

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
        code: String,
        description: String
    ) {
        self.id = id
        self.name = name
        self.code = code
        self.description = description
    }

}
