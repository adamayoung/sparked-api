//
//  AzureBlobStorageAuthorizationHeaderBuilder.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import Vapor

struct AzureBlobStorageAuthorizationHeaderBuilder {

    private init() {}

    static func build(
        httpMethod: String,
        contentLength: Int = 0,
        contentType: String,
        date: String,
        storageAccount: String,
        containerName: String,
        blobName: String,
        accountKey: String
    ) throws(FileStorageError) -> String {
        let blobTypeHeader = "x-ms-blob-type:BlockBlob"
        let dateHeader = "x-ms-date:\(date)"
        let versionHeader = "x-ms-version:2021-04-10"

        let stringToSign =
            "\(httpMethod)\n"  // HTTP Verb (e.g., PUT)
            + "\n"  // Content Encoding
            + "\n"  // Content Language
            + "\(contentLength == 0 ? "" : "\(contentLength)" )\n"  // Content Length
            + "\n"  // Content MD5
            + "\(contentType)\n"  // Content Type
            + "\n"  // Date
            + "\n"  // If-Modified-Since
            + "\n"  // If-Match
            + "\n"  // If-None-Match
            + "\n"  // If-Unmodified-Since
            + "\n"  // Range
            + "\(blobTypeHeader)\n"  // Custom headers
            + "\(dateHeader)\n" + "\(versionHeader)\n"
            + "/\(storageAccount)/\(containerName)/\(blobName)"  // Resource

        guard let keyData = Data(base64Encoded: accountKey) else {
            throw .unknown()
        }

        let symmetricKey = SymmetricKey(data: keyData)
        guard let data = stringToSign.data(using: .utf8) else {
            throw .unknown()
        }
        let authenticationCode = HMAC<SHA256>.authenticationCode(for: data, using: symmetricKey)
        let signature = Data(authenticationCode).base64EncodedString()

        return "SharedKey \(storageAccount):\(signature)"
    }

}
