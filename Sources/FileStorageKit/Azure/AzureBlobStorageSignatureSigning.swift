//
//  AzureBlobStorageSignatureSigning.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

protocol AzureBlobStorageSignatureSigning: Sendable {

    func sign(_ signature: String) async throws(FileStorageError) -> String

}
