//
//  FileStorageFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import NIO
import Vapor

package final class FileStorageFactory {

    private init() {}

    package static func makeLocalFileStorage(
        configuration: LocalStorageConfiguration,
        fileIO: NonBlockingFileIO
    ) -> some FileStorage {
        LocalFileStorage(
            configuration: configuration,
            fileIO: fileIO
        )
    }

    package static func makeAzureFileStorage(
        configuration: AzureStorageConfiguration,
        client: some Client
    ) -> some FileStorage {
        AzureRESTBlobStorage(
            configuration: configuration,
            signer: Self.makeSigner(accountKey: configuration.accountKey),
            client: client
        )
    }

}

extension FileStorageFactory {

    private static func makeSigner(
        accountKey: String
    ) -> some AzureBlobStorageSignatureSigning {
        AzureBlobStorageSignatureSigner(accountKey: accountKey)
    }

}
