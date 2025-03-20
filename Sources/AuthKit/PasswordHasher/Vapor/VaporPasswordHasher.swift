//
//  VaporPasswordHasher.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import Vapor

final class VaporPasswordHasher: PasswordHasher {

    private let hasher: Vapor.PasswordHasher

    init(hasher: Vapor.PasswordHasher) {
        self.hasher = hasher
    }

    func hash(_ password: String) throws -> String {
        try hasher.hash(password)
    }

    func verify(_ password: String, created digest: String) throws -> Bool {
        try hasher.verify(password, created: digest)
    }

}
