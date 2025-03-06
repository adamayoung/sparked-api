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

    init(fileIO: NonBlockingFileIO, basePath: String = "./storage") {
        self.fileIO = fileIO
        self.basePath = basePath
    }

    func write(data: Data, to path: String) async throws {
        let buffer = ByteBuffer(data: data)
        let fullPath = self.fullPath(for: path)
        let fileHandle = try NIOFileHandle(
            path: fullPath, mode: .write, flags: .allowFileCreation())
        defer {
            try? fileHandle.close()
        }

        do {
            try await fileIO.write(fileHandle: fileHandle, buffer: buffer)
        } catch let error {
            throw error
        }
    }

    func url(for path: String) async throws -> URL {
        let fullPath = self.fullPath(for: path)
        guard let url = URL(string: fullPath) else {
            fatalError("Cannot create URL from path: \(fullPath)")
        }

        return url
    }

}

extension LocalFileStorage {

    private func fullPath(for path: String) -> String {
        "\(basePath)/\(path)"
    }

}
