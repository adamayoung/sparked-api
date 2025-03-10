//
//  AzureBlobStorageResourceURLBuilder.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation

struct AzureBlobStorageResourceURLBuilder {

    private init() {}

    static func build(
        storageAccount: String,
        containerName: String,
        blobName: String
    ) throws(FileStorageError) -> URL {
        let urlString =
            "https://\(storageAccount).blob.core.windows.net/\(containerName)/\(blobName)"
        guard let url = URL(string: urlString) else {
            throw .invalidURL
        }

        return url
    }

}
