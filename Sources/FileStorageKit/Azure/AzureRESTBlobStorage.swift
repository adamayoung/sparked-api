//
//  AzureRESTBlobStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import Vapor

final class AzureRESTBlobStorage: FileStorage, Sendable {

    private static let blobType = "BlockBlob"
    private static let version = "2021-04-10"

    private let configuration: AzureStorageConfiguration
    private let signer: any AzureBlobStorageSignatureSigning
    private let client: any Client

    init(
        configuration: AzureStorageConfiguration,
        signer: some AzureBlobStorageSignatureSigning,
        client: some Client
    ) {
        self.configuration = configuration
        self.signer = signer
        self.client = client
    }

    func url(containerName: String, filename: String) async throws(FileStorageError) -> URL {
        let url = try AzureBlobStorageResourceURLBuilder.build(
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: filename
        )

        return url
    }

    func upload(
        _ data: Data,
        containerName: String,
        filename: String
    ) async throws(FileStorageError) {
        let response = try await performRequest(
            httpMethod: .PUT,
            containerName: containerName,
            blobName: filename,
            data: data,
            contentType: "image/jpeg"
        )

        guard response.status == .created else {
            throw .unknown()
        }
    }

    func delete(containerName: String, filename: String) async throws(FileStorageError) {
        let response = try await performRequest(
            httpMethod: .DELETE,
            containerName: containerName,
            blobName: filename
        )

        switch response.status {
        case .accepted: break
        case .notFound: throw .notFound
        default: throw .unknown()
        }
    }

    func healthCheck() async -> Bool {
        true
    }

}

extension AzureRESTBlobStorage {

    private func performRequest(
        httpMethod: HTTPMethod,
        containerName: String,
        blobName: String? = nil,
        data: Data? = nil,
        contentType: String = ""
    ) async throws(FileStorageError) -> ClientResponse {
        let url = try AzureBlobStorageResourceURLBuilder.build(
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: blobName
        )

        let currentDate = Self.generateDate()
        let contentLength = data?.count ?? 0

        let signature = AzureBlobStorageSignatureBuilder.build(
            httpMethod: httpMethod.rawValue,
            contentLength: contentLength,
            contentType: contentType,
            blobTypeHeader: "\(AzureHTTPHeader.blobType):\(Self.blobType)",
            dateHeader: "\(AzureHTTPHeader.date):\(currentDate)",
            versionHeader: "\(AzureHTTPHeader.version):\(Self.version)",
            storageAccount: configuration.accountName,
            containerName: containerName,
            blobName: blobName
        )

        let signedSignature = try await signer.sign(signature)
        let authorizationHeader = "SharedKey \(configuration.accountName):\(signedSignature)"

        var request = ClientRequest(url: URI(string: url.absoluteString))
        request.method = httpMethod
        if let data {
            request.body = ByteBuffer(data: data)
        }
        request.headers.add(name: AzureHTTPHeader.contentType, value: contentType)
        request.headers.add(name: AzureHTTPHeader.contentLength, value: "\(contentLength)")
        request.headers.add(name: AzureHTTPHeader.blobType, value: Self.blobType)
        request.headers.add(name: AzureHTTPHeader.date, value: currentDate)
        request.headers.add(name: AzureHTTPHeader.version, value: Self.version)
        request.headers.add(name: AzureHTTPHeader.authorization, value: authorizationHeader)

        let response: ClientResponse
        do {
            response = try await client.send(request)
        } catch let error {
            throw .network(error)
        }

        return response
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
