//
//  UserContext.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ProfileDomain

package protocol UserContext {

    var userID: UUID? { get }
    var userRoles: [String]? { get }

}

extension UserContext {

    var isUser: Bool {
        userRoles?.contains("USER") ?? false
    }

    var isAdmin: Bool {
        userRoles?.contains("ADMIN") ?? false
    }

    var isSystem: Bool {
        userRoles?.contains("SYSTEM") ?? false
    }

    func isOwner(_ ownerID: User.ID) -> Bool {
        guard let userID else {
            return false
        }

        return ownerID == userID
    }

    func canRead(ownerID: User.ID) -> Bool {
        if isAdmin || isSystem {
            return true
        }

        return true
    }

    func canWrite(ownerID: User.ID) -> Bool {
        if isAdmin || isSystem {
            return true
        }

        guard let userID else {
            return false
        }

        return ownerID == userID
    }

}
