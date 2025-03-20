//
//  RoleDTO+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import IdentityApplication
import Testing

extension RoleDTO {

    static func mock(
        id: UUID? = UUID(uuidString: "83E45F5F-419D-4031-8A63-A0A24ED80590"),
        code: String = "USER",
        name: String = "User",
        description: String = "User mock role"
    ) throws -> RoleDTO {
        try RoleDTO(
            id: #require(id),
            code: code,
            name: name,
            description: description
        )
    }

    static func userMock(
        id: UUID? = UUID(uuidString: "83E45F5F-419D-4031-8A63-A0A24ED80590")
    ) throws -> RoleDTO {
        try RoleDTO.mock(
            id: id,
            code: "USER",
            name: "User",
            description: "User mock role"
        )
    }

    static func adminMock(
        id: UUID? = UUID(uuidString: "278444FE-E9D3-4F34-B744-04D5C1799E88")
    ) throws -> RoleDTO {
        try RoleDTO.mock(
            id: id,
            code: "ADMIN",
            name: "Admin",
            description: "Administrator mock role"
        )
    }

    static func systemMock(
        id: UUID? = UUID(uuidString: "A4654316-8A85-481E-A25A-F7371D73C490")
    ) throws -> RoleDTO {
        try RoleDTO.mock(
            id: id,
            code: "SYSTEM",
            name: "System",
            description: "System mock role"
        )
    }

}
