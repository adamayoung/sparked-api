//
//  UserDTO+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import IdentityApplication
import Testing

extension UserDTO {

    // swift-format-ignore: NeverUseForceTry
    static func mock(
        id: UUID? = UUID(uuidString: "5DBFF1D4-C857-4B45-AD38-549628449992"),
        firstName: String = "Dave",
        familyName: String = "Smith",
        fullName: String = "Dave Smith",
        email: String = "dave@email.com",
        roles: [RoleDTO] = [try! RoleDTO.userMock()],
        isVerified: Bool = true,
        isActive: Bool = true
    ) throws -> UserDTO {
        UserDTO(
            id: try #require(id),
            firstName: firstName,
            familyName: familyName,
            fullName: fullName,
            email: email,
            roles: roles,
            isVerified: isVerified,
            isActive: isActive
        )
    }

}
