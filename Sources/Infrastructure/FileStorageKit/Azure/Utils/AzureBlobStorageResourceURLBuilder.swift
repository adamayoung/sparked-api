//
//  AzureBlobStorageResourceURLBuilder.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation

struct AzureBlobStorageResourceURLBuilder {

    private init() {}

    static func build(
        storageAccount: String,
        containerName: String,
        blobName: String? = nil
    ) throws(FileStorageError) -> URL {
        var urlString = "https://\(storageAccount).blob.core.windows.net/\(containerName)"
        if let blobName {
            urlString += "/\(blobName)"
        }

        guard let url = URL(string: urlString) else {
            throw .invalidURL
        }

        return url
    }

}
