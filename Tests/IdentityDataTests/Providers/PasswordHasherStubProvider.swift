//
//  PasswordHasherStubProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityData

final class PasswordHasherStubProvider: PasswordHasherProvider, @unchecked Sendable {

    var hashResult: Result<String, Error> = .success("")
    private(set) var hashLastPassword: String?

    var verifyResult: Result<Bool, Error> = .success(true)
    private(set) var verifyLastPassword: String?
    private(set) var verifyLastCreated: String?

    init() {}

    func hash(_ password: String) throws -> String {
        self.hashLastPassword = password

        return try hashResult.get()
    }

    func verify(_ password: String, created digest: String) throws -> Bool {
        self.verifyLastPassword = password
        self.verifyLastCreated = digest

        return try verifyResult.get()
    }

}
