//
//  PasswordHasherProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package protocol PasswordHasherProvider: Sendable {

    func hash<Password: DataProtocol>(_ password: Password) throws -> [UInt8]

    func verify<Password: DataProtocol, Digest: DataProtocol>(
        _ password: Password,
        created digest: Digest
    ) throws -> Bool

}

extension PasswordHasherProvider {

    package func hash(_ password: String) throws -> String {
        try String(decoding: self.hash([UInt8](password.utf8)), as: UTF8.self)
    }

    package func verify(_ password: String, created digest: String) throws -> Bool {
        try self.verify(
            [UInt8](password.utf8),
            created: [UInt8](digest.utf8)
        )
    }

}
