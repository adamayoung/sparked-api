//
//  ImageDefaultRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class ImageDefaultRepository: ImageRepository {

    private let remoteDataSource: any ImageRemoteDataSource

    init(remoteDataSource: some ImageRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ photoData: Data, filename: String) async throws {
        try await remoteDataSource.create(photoData, filename: filename)
    }

    func url(for filename: String) async throws -> URL {
        try await remoteDataSource.url(for: filename)
    }

    func delete(filename: String) async throws {
        try await remoteDataSource.delete(filename: filename)
    }

}
