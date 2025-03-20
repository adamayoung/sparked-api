//
//  AzureBlobStorageSignatureBuilderTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import Testing

@testable import FileStorageKit

@Suite("AzureBlobStorageSignatureBuilder")
struct AzureBlobStorageSignatureBuilderTests {

    @Test("build when content length is zero returns expected signature")
    func buildWhenContentLengthIsZeroReturnsExpectedSignature() {
        let signature = AzureBlobStorageSignatureBuilder.build(
            httpMethod: "DELETE",
            contentLength: 0,
            contentType: "",
            blobTypeHeader: "BlockBlob",
            dateHeader: "x-ms-date:2025-03-17T12:34:56Z",
            versionHeader: "x-ms-version:2021-04-10",
            storageAccount: "TestStorageAccount",
            containerName: "TestContainerName",
            blobName: "TestBlobName.txt"
        )
        let expectedSignature =
            "DELETE\n"  // HTTP Verb
            + "\n"  // Content Encoding
            + "\n"  // Content Language
            + "\n"  // Content Length
            + "\n"  // Content MD5
            + "\n"  // Content Type
            + "\n"  // Date
            + "\n"  // If-Modified-Since
            + "\n"  // If-Match
            + "\n"  // If-None-Match
            + "\n"  // If-Unmodified-Since
            + "\n"  // Range
            + "BlockBlob\n"  // Custom headers
            + "x-ms-date:2025-03-17T12:34:56Z\n"
            + "x-ms-version:2021-04-10\n"
            + "/TestStorageAccount/TestContainerName/TestBlobName.txt"

        #expect(signature == expectedSignature)
    }

    @Test("build when content length is not zero returns expected signature")
    func buildWhenContentLengthIsNotZeroReturnsExpectedSignature() {
        let signature = AzureBlobStorageSignatureBuilder.build(
            httpMethod: "PUT",
            contentLength: 10,
            contentType: "image/jpeg",
            blobTypeHeader: "BlockBlob",
            dateHeader: "x-ms-date:2025-03-17T12:34:56Z",
            versionHeader: "x-ms-version:2021-04-10",
            storageAccount: "TestStorageAccount",
            containerName: "TestContainerName",
            blobName: "TestBlobName.txt"
        )
        let expectedSignature =
            "PUT\n"  // HTTP Verb
            + "\n"  // Content Encoding
            + "\n"  // Content Language
            + "10\n"  // Content Length
            + "\n"  // Content MD5
            + "image/jpeg\n"  // Content Type
            + "\n"  // Date
            + "\n"  // If-Modified-Since
            + "\n"  // If-Match
            + "\n"  // If-None-Match
            + "\n"  // If-Unmodified-Since
            + "\n"  // Range
            + "BlockBlob\n"  // Custom headers
            + "x-ms-date:2025-03-17T12:34:56Z\n"
            + "x-ms-version:2021-04-10\n"
            + "/TestStorageAccount/TestContainerName/TestBlobName.txt"

        #expect(signature == expectedSignature)
    }

}
