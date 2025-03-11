//
//  AzureRESTBlobStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import Vapor

package final class AzureRESTBlobStorage: FileStorage, Sendable {

    private let configuration: AzureStorageConfiguration
    private let client: any Client

    package init(
        configuration: AzureStorageConfiguration,
        client: some Client
    ) {
        self.configuration = configuration
        self.client = client
    }

    package func upload(
        _ data: Data,
        containerName: String,
        filename: String
    ) async throws(FileStorageError) {
        let url = try AzureBlobStorageResourceURLBuilder.build(
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: filename
        )

        let currentDate = Self.generateDate()
        let httpMethod: HTTPMethod = .PUT
        let contentLength = data.count
        let contentType = "image/jpeg"

        let authorizationHeader = try AzureBlobStorageAuthorizationHeaderBuilder.build(
            httpMethod: httpMethod.rawValue,
            contentLength: contentLength,
            contentType: contentType,
            date: currentDate,
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: filename,
            accountKey: configuration.accountKey
        )

        var request = ClientRequest(url: URI(string: url.absoluteString))
        request.method = httpMethod
        request.body = ByteBuffer(data: data)
        request.headers.add(name: "Content-Type", value: contentType)
        request.headers.add(name: "Content-Length", value: "\(contentLength)")
        request.headers.add(name: "x-ms-blob-type", value: "BlockBlob")
        request.headers.add(name: "x-ms-date", value: currentDate)
        request.headers.add(name: "x-ms-version", value: "2021-04-10")
        request.headers.add(name: "Authorization", value: authorizationHeader)

        let response: ClientResponse
        do {
            response = try await client.send(request)
        } catch let error {
            throw .network(error)
        }

        guard response.status == .created else {
            throw .unknown()
        }
    }

    package func url(
        containerName: String,
        filename: String
    ) async throws(FileStorageError) -> URL {
        let url = try AzureBlobStorageResourceURLBuilder.build(
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: filename
        )

        return url
    }

    package func delete(containerName: String, filename: String) async throws(FileStorageError) {
        let url = try AzureBlobStorageResourceURLBuilder.build(
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: filename
        )

        let currentDate = Self.generateDate()
        let httpMethod: HTTPMethod = .DELETE

        let authorizationHeader = try AzureBlobStorageAuthorizationHeaderBuilder.build(
            httpMethod: httpMethod.rawValue,
            contentType: "",
            date: currentDate,
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: filename,
            accountKey: configuration.accountKey
        )

        var request = ClientRequest(url: URI(string: url.absoluteString))
        request.method = httpMethod
        request.headers.add(name: "Content-Type", value: "")
        request.headers.add(name: "Content-Length", value: "0")
        request.headers.add(name: "x-ms-blob-type", value: "BlockBlob")
        request.headers.add(name: "x-ms-date", value: currentDate)
        request.headers.add(name: "x-ms-version", value: "2021-04-10")
        request.headers.add(name: "Authorization", value: authorizationHeader)

        let response: ClientResponse
        do {
            response = try await client.send(request)
        } catch let error {
            throw .network(error)
        }

        switch response.status {
        case .accepted: break
        case .notFound: throw .notFound
        default: throw .unknown()
        }
    }

}

extension AzureRESTBlobStorage {

    private static func generateDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss 'GMT'"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }

}
