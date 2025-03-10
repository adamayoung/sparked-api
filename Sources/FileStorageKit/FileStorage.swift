//
//  FileStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation

package protocol FileStorage {

    func upload(
        _ data: Data,
        containerName: String,
        filename: String
    ) async throws(FileStorageError)

    func url(containerName: String, filename: String) async throws(FileStorageError) -> URL

}
