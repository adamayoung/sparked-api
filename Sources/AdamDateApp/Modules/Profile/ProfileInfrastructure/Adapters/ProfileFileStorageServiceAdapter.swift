//
//  ProfileFileStorageServiceAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import FileStorageKit
import Foundation
import ProfileInfrastructure

final class ProfileFileStorageServiceAdapter: FileStorageService {

    private let fileStorage: any FileStorage
    private let containerName: String

    init(fileStorage: some FileStorage, containerName: String) {
        self.fileStorage = fileStorage
        self.containerName = containerName
    }

    func save(_ data: Data, filename: String) async throws {
        try await fileStorage.upload(data, containerName: containerName, filename: filename)
    }

    func url(for filename: String) async throws -> URL {
        try await fileStorage.url(containerName: containerName, filename: filename)
    }

    func delete(filename: String) async throws {
        try await fileStorage.delete(containerName: containerName, filename: filename)
    }

}
