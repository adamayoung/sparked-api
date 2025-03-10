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

    package static func makeLocalFileStorage(fileIO: NonBlockingFileIO) -> some FileStorage {
        LocalFileStorage(fileIO: fileIO)
    }

    package static func makeAzureFileStorage(
        configuration: AzureStorageConfiguration,
        client: some Client
    ) -> some FileStorage {
        AzureRESTBlobStorage(configuration: configuration, client: client)
    }

}
