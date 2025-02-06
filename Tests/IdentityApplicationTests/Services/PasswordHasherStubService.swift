//
//  PasswordHasherStubService.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityApplication

final class PasswordHasherStubService: PasswordHasherService, @unchecked Sendable {

    var hashResult: Result<String, Error> = .success("")
    private(set) var hashWasCalled = false
    private(set) var hashLastPassword: String?

    var verifyResult: Result<Bool, Error> = .success(true)
    private(set) var verifyWasCalled = false
    private(set) var verifyLastPassword: String?
    private(set) var verifyLastCreated: String?

    init() {}

    func hash(_ password: String) throws -> String {
        hashWasCalled = true
        hashLastPassword = password

        return try hashResult.get()
    }

    func verify(_ password: String, created digest: String) throws -> Bool {
        verifyWasCalled = true
        verifyLastPassword = password
        verifyLastCreated = digest

        return try verifyResult.get()
    }

}
