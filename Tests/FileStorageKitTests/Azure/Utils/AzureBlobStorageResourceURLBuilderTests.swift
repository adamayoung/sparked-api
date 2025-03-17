//
//  AzureBlobStorageResourceURLBuilderTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import Testing

@testable import FileStorageKit

@Suite("AzureBlobStorageResourceURLBuilder")
struct AzureBlobStorageResourceURLBuilderTests {

    @Test("build returns expected URL")
    func buildReturnsExpectedURL() throws {
        let storageAccount = "storageAccount"
        let containerName = "container"
        let blobName = "blob"
        let expectedURL = try #require(
            URL(
                string:
                    "https://\(storageAccount).blob.core.windows.net/\(containerName)/\(blobName)"))

        let url = try AzureBlobStorageResourceURLBuilder.build(
            storageAccount: storageAccount,
            containerName: containerName,
            blobName: blobName
        )

        #expect(url == expectedURL)
    }

}
