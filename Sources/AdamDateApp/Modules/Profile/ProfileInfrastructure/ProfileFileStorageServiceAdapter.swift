//
//  ProfileFileStorageServiceAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import ProfileInfrastructure
import Foundation

final class ProfileFileStorageServiceAdapter: FileStorageService {

    private let fileStorage: any FileStorage
    private let bucketName: String

    init(fileStorage: some FileStorage, bucketName: String) {
        self.fileStorage = fileStorage
        self.bucketName = bucketName
    }

    func save(_ data: Data, filename: String) async throws {
        let path = path(for: filename)

        try await fileStorage.write(data: data, to: path)
    }

    func url(for filename: String) async throws -> URL {
        let path = path(for: filename)

        return try await fileStorage.url(for: path)
    }

}

extension ProfileFileStorageServiceAdapter {

    private func path(for filename: String) -> String {
        "\(bucketName)/\(filename)"
    }

}
