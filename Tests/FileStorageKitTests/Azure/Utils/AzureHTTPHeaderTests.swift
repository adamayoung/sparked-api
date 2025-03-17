//
//  AzureHTTPHeaderTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import Testing

@testable import FileStorageKit

@Suite("AzureHTTPHeader")
struct AzureHTTPHeaderTests {

    @Test("contentType returns correct value")
    func contentTypeReturnsCorrectValue() {
        #expect(AzureHTTPHeader.contentType == "Content-Type")
    }

    @Test("contentLength returns correct value")
    func contentLengthReturnsCorrectValue() {
        #expect(AzureHTTPHeader.contentLength == "Content-Length")
    }

    @Test("authorization returns correct value")
    func authorizationReturnsCorrectValue() {
        #expect(AzureHTTPHeader.authorization == "Authorization")
    }

    @Test("date returns correct value")
    func dateReturnsCorrectValue() {
        #expect(AzureHTTPHeader.date == "x-ms-date")
    }

    @Test("blobType returns correct value")
    func blobTypeReturnsCorrectValue() {
        #expect(AzureHTTPHeader.blobType == "x-ms-blob-type")
    }

    @Test("version returns correct value")
    func versionReturnsCorrectValue() {
        #expect(AzureHTTPHeader.version == "x-ms-version")
    }

}
