//
//  PasswordHasherStubService.swift
//  SparkedAPI
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityApplication

final class PasswordHasherStubService: PasswordHasherService, @unchecked Sendable {

    var hashResult: Result<String, any Error> = .success("")
    private(set) var hashWasCalled = false
    private(set) var lastHashParameter: String?

    var verifyResult: Result<Bool, any Error> = .success(true)
    private(set) var verifyWasCalled = false
    private(set) var lastVerifyParameters: (password: String, created: String)?

    init() {}

    func hash(_ password: String) throws -> String {
        hashWasCalled = true
        lastHashParameter = password

        return try hashResult.get()
    }

    func verify(_ password: String, created digest: String) throws -> Bool {
        verifyWasCalled = true
        lastVerifyParameters = (password: password, created: digest)

        return try verifyResult.get()
    }

}
