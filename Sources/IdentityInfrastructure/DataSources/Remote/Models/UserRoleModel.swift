//
//  UserRoleModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Fluent
import Foundation

final class UserRoleModel: Model, @unchecked Sendable {

    static let schema = "user+role"

    @ID var id: UUID?

    @Parent(key: "user_id")
    var user: UserModel

    @Parent(key: "role_id")
    var role: RoleModel

    init() {}

    init(
        id: UUID? = nil,
        user: UserModel,
        role: RoleModel
    ) throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$role.id = try role.requireID()
    }

}
