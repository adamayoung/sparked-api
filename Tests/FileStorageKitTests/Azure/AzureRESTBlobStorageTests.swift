//
//  AzureRESTBlobStorageTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import Testing
import Vapor

@testable import FileStorageKit

@Suite("AzureRESTBlobStorage")
@MainActor
struct AzureRESTBlobStorageTests {

    let storage: AzureRESTBlobStorage
    let configuration: AzureStorageConfiguration
    let signer: AzureBlobStorageSignatureStubSigner
    let client: ClientStub
    let eventLoopGroup: any EventLoopGroup

    init() {
        self.configuration = AzureStorageConfiguration(
            accountName: "TestAccountName",
            accountKey: "VGVzdEFjY291bnRLZXk="
        )
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        self.signer = AzureBlobStorageSignatureStubSigner()
        self.client = ClientStub(eventLoop: eventLoopGroup.next())

        self.storage = AzureRESTBlobStorage(
            configuration: configuration,
            signer: signer,
            client: client
        )
    }

    @Test("upload when successful does not throw error")
    func uploadWhenSuccessfulDoesNotThrowError() async throws {
        let data = try #require("test".data(using: .utf8))
        let containerName = "TestContainerName"
        let filename = "test.txt"
        signer.signResult = .success("signedRequest")

        let response = ClientResponse(status: .created)
        client.response = response

        try await storage.upload(data, containerName: containerName, filename: filename)
        #expect(client.sendWasCalled)
        #expect(client.lastSendRequest?.method == .PUT)
        #expect(
            client.lastSendRequest?.url
                == URI(
                    string:
                        "https://TestAccountName.blob.core.windows.net/TestContainerName/test.txt"))
    }

    @Test("delete when successful does not throw error")
    func deleteWhenSuccessfulDoesNotThrowError() async throws {
        let containerName = "TestContainerName"
        let filename = "test.txt"
        signer.signResult = .success("signedRequest")

        let response = ClientResponse(status: .accepted)
        client.response = response

        try await storage.delete(containerName: containerName, filename: filename)
        #expect(client.sendWasCalled)
        #expect(client.lastSendRequest?.method == .DELETE)
        #expect(
            client.lastSendRequest?.url
                == URI(
                    string:
                        "https://TestAccountName.blob.core.windows.net/TestContainerName/test.txt"))
    }

    @Test("delete when blob not found throws not found error")
    func deleteWhenBlobNotFoundThrowsNotFoundError() async throws {
        let containerName = "TestContainerName"
        let filename = "test.txt"
        signer.signResult = .success("signedRequest")

        let response = ClientResponse(status: .notFound)
        client.response = response

        await #expect(throws: FileStorageError.notFound) {
            try await storage.delete(containerName: containerName, filename: filename)
        }
    }

}
