//
//  UserContext+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ProfileApplication

struct UserMockContext: UserContext {

    let userID: UUID?
    let userRoles: [String]?

    fileprivate init(userID: UUID? = nil, userRoles: [String]? = nil) {
        self.userID = userID
        self.userRoles = userRoles
    }

}

extension UserMockContext {

    static func mock(
        userID: UUID? = UUID(uuidString: "0ECE1765-A91E-47F1-969E-06BE50F9D356"),
        userRoles: [String]? = ["USER"]
    ) -> some UserContext {
        UserMockContext(
            userID: userID,
            userRoles: userRoles
        )
    }

    static func withUserRoleMock(
        userID: UUID? = UUID(uuidString: "EC3E8260-873E-41BA-92FB-10216CB0537E")
    ) -> some UserContext {
        Self.mock(
            userID: userID,
            userRoles: ["USER"]
        )
    }

    static func withAdminRoleMock(
        userID: UUID? = UUID(uuidString: "02BB0C07-7E1B-48F8-B43C-D05DEE2933AD")
    ) -> some UserContext {
        Self.mock(
            userID: userID,
            userRoles: ["ADMIN"]
        )
    }

    static func withSystemRoleMock(
        userID: UUID? = UUID(uuidString: "02BB0C07-7E1B-48F8-B43C-D05DEE2933AD")
    ) -> some UserContext {
        Self.mock(
            userID: userID,
            userRoles: ["SYSTEM"]
        )
    }

}
