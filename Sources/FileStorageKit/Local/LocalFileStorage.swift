//
//  VaporFileStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import NIO

final class LocalFileStorage: FileStorage {

    private let fileIO: NonBlockingFileIO
    private let basePath: String

    init(
        fileIO: NonBlockingFileIO,
        basePath: String = "./storage"
    ) {
        self.fileIO = fileIO
        self.basePath = basePath
    }

    func upload(
        _ data: Data,
        containerName: String,
        filename: String
    ) async throws(FileStorageError) {
        let buffer = ByteBuffer(data: data)
        let fullPath = self.fullPath(containerName: containerName, filename: filename)
        let fileHandle: NIOFileHandle
        do {
            fileHandle = try NIOFileHandle(
                path: fullPath,
                mode: .write,
                flags: .allowFileCreation()
            )
        } catch let error {
            throw .unknown(error)
        }

        defer {
            try? fileHandle.close()
        }

        do {
            try await fileIO.write(fileHandle: fileHandle, buffer: buffer)
        } catch let error {
            throw .unknown(error)
        }
    }

    func url(containerName: String, filename: String) async throws(FileStorageError) -> URL {
        let fullPath = self.fullPath(containerName: containerName, filename: filename)
        guard let url = URL(string: fullPath) else {
            throw .invalidURL
        }

        return url
    }

}

extension LocalFileStorage {

    private func fullPath(containerName: String, filename: String) -> String {
        "\(basePath)/\(containerName)/\(filename)"
    }

}
