//
//  UserContextStub.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ProfileApplication

struct UserContextStub: UserContext {

    let userID: UUID?
    let userRoles: [String]?

    init(userID: UUID? = nil, userRoles: [String]? = nil) {
        self.userID = userID
        self.userRoles = userRoles
    }

}

extension UserContextStub {

    static var user: UserContextStub {
        .init(
            userID: UUID(uuidString: "81F48871-CD04-4DCA-B995-A825F6CC7965"),
            userRoles: ["USER"]
        )
    }

    static var admin: UserContextStub {
        .init(
            userID: UUID(uuidString: "A0DE47A2-54D6-43E4-92EF-32CCF0A5E182"),
            userRoles: ["ADMIN", "USER"]
        )
    }

}
