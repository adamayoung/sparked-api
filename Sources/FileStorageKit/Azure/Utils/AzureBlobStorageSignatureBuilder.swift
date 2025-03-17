//
//  AzureBlobStorageSignatureBuilder.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

struct AzureBlobStorageSignatureBuilder {

    private init() {}

    static func build(
        httpMethod: String,
        contentLength: Int,
        contentType: String,
        blobTypeHeader: String,
        dateHeader: String,
        versionHeader: String,
        storageAccount: String,
        containerName: String,
        blobName: String? = nil
    ) -> String {
        var path = "/\(storageAccount)/\(containerName)"
        if let blobName {
            path += "/\(blobName)"
        }

        let signature =
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
            + "\(dateHeader)\n"
            + "\(versionHeader)\n"
            + "\(path)"

        return signature
    }

}
