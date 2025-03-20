//
//  User+UserContext.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import AuthKit
import Foundation
import ProfileApplication

extension TokenPayload: UserContext {

    package var userID: UUID? {
        UUID(uuidString: self.subject.value)
    }

    package var userRoles: [String]? {
        self.roles.value
    }

}
