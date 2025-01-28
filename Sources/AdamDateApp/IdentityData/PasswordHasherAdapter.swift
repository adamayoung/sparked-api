//
//  PasswordHasherAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityData
import Vapor

final class PasswordHasherAdapter: PasswordHasherProvider {

    private let hasher: PasswordHasher

    init(hasher: PasswordHasher) {
        self.hasher = hasher
    }

    func hash<Password: DataProtocol>(_ password: Password) throws -> [UInt8] {
        try hasher.hash(password)
    }

    func verify<Password: DataProtocol, Digest: DataProtocol>(
        _ password: Password,
        created digest: Digest
    ) throws -> Bool {
        try hasher.verify(password, created: digest)
    }

}
