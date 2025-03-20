//
//  UserCredential.swift
//  SparkedAPI
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package struct UserCredential: Equatable, Sendable {

    package let email: String
    package let password: String

    package init(email: String, password: String) {
        self.email = email
        self.password = password
    }

}
