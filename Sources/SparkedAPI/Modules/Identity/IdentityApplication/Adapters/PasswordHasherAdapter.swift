//
//  PasswordHasherAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 24/01/2025.
//

import AuthKit
import Foundation
import IdentityApplication

final class PasswordHasherAdapter: PasswordHasherService {

    private let hasher: any PasswordHasher

    init(hasher: some PasswordHasher) {
        self.hasher = hasher
    }

    func hash(_ password: String) throws -> String {
        try hasher.hash(password)
    }

    func verify(_ password: String, created digest: String) throws -> Bool {
        try hasher.verify(password, created: digest)
    }

}
