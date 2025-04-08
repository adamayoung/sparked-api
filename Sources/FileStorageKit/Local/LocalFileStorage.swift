//
//  VaporFileStorage.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import NIO
import NIOFileSystem

final class LocalFileStorage: FileStorage {

    private let configuration: LocalStorageConfiguration
    private let fileIO: NonBlockingFileIO

    init(
        configuration: LocalStorageConfiguration,
        fileIO: NonBlockingFileIO
    ) {
        self.configuration = configuration
        self.fileIO = fileIO
    }

    func url(containerName: String, filename: String) async throws(FileStorageError) -> URL {
        let fullPath = self.fullPath(containerName: containerName, filename: filename)
        guard let url = URL(string: fullPath) else {
            throw .invalidURL
        }

        return url
    }

    func upload(
        _ data: Data,
        containerName: String,
        filename: String
    ) async throws(FileStorageError) {
        let buffer = ByteBuffer(data: data)
        let fullPath = self.fullPath(containerName: containerName, filename: filename)

        do {
            _ = try await FileSystem.shared.withFileHandle(
                forWritingAt: FilePath(fullPath),
                options: .newFile(replaceExisting: true)
            ) { file in
                try await file.write(contentsOf: buffer, toAbsoluteOffset: 0)
            }
        } catch let error {
            throw .unknown(error)
        }
    }

    func delete(containerName: String, filename: String) async throws(FileStorageError) {
        let fullPath = self.fullPath(containerName: containerName, filename: filename)

        do {
            try await fileIO.remove(path: fullPath)
        } catch let error {
            throw .unknown(error)
        }
    }

    func healthCheck() async -> Bool {
        do {
            _ = try await fileIO.listDirectory(path: configuration.path)
        } catch {
            return false
        }

        return true
    }

}

extension LocalFileStorage {

    private func fullPath(containerName: String, filename: String) -> String {
        "\(configuration.path)/\(containerName)/\(filename)"
    }

}
