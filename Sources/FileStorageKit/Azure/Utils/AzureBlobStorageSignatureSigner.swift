//
//  AzureBlobStorageSignatureSigner.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import Vapor

final class AzureBlobStorageSignatureSigner: AzureBlobStorageSignatureSigning {

    private let accountKey: String

    init(accountKey: String) {
        self.accountKey = accountKey
    }

    func sign(_ signature: String) async throws(FileStorageError) -> String {
        guard let keyData = Data(base64Encoded: accountKey) else {
            throw .unknown()
        }

        let symmetricKey = SymmetricKey(data: keyData)
        guard let data = signature.data(using: .utf8) else {
            throw .unknown()
        }

        let authenticationCode = HMAC<SHA256>.authenticationCode(for: data, using: symmetricKey)
        let signedSignature = Data(authenticationCode).base64EncodedString()

        return signedSignature
    }

}
