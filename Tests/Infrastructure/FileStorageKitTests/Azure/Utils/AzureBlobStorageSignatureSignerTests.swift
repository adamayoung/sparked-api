//
//  AzureBlobStorageSignatureSignerTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import Testing

@testable import FileStorageKit

@Suite("AzureBlobStorageSignatureSigner")
struct AzureBlobStorageSignatureSignerTests {

    let signer: AzureBlobStorageSignatureSigner

    init() {
        self.signer = AzureBlobStorageSignatureSigner(accountKey: "VGVzdEFjY291bnRLZXk=")
    }

    @Test("sign returns expected string")
    func signReturnsExpectedString() async throws {
        let signature = "test signature"
        let expectedSignature = "vKecIvlmEGf19bsO6iKoCk97jtdbM3U/HE67IquaXnE="

        let signedSignature = try await signer.sign(signature)

        #expect(signedSignature == expectedSignature)
    }

}
