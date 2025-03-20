//
//  AzureBlobStorageSignatureStubSigner.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import Testing

@testable import FileStorageKit

final class AzureBlobStorageSignatureStubSigner:
    AzureBlobStorageSignatureSigning, @unchecked Sendable
{

    var signResult: Result<String, FileStorageError> = .failure(.unknown())
    private(set) var signWasCalled = false
    private(set) var lastSignSignature: String?

    init() {}

    func sign(_ signature: String) throws(FileStorageError) -> String {
        signWasCalled = true
        lastSignSignature = signature

        return try signResult.get()
    }

}
