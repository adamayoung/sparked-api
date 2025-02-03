//
//  PasswordHasherAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityInfrastructure
import Vapor

final class PasswordHasherAdapter: PasswordHasherProvider {

    private let hasher: PasswordHasher

    init(hasher: PasswordHasher) {
        self.hasher = hasher
    }

    func hash(_ password: String) throws -> String {
        try hasher.hash(password)
    }

    func verify(_ password: String, created digest: String) throws -> Bool {
        try hasher.verify(password, created: digest)
    }

}
