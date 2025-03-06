//
//  ImageRemoteStorageDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class ImageRemoteStorageDataSource: ImageRemoteDataSource {

    private let fileStorageService: any FileStorageService

    init(fileStorageService: some FileStorageService) {
        self.fileStorageService = fileStorageService
    }

    func create(_ photoData: Data, filename: String) async throws(ImageRepositoryError) {
        do {
            try await fileStorageService.save(photoData, filename: filename)
        } catch let error {
            throw .unknown(error)
        }
    }

    func url(for filename: String) async throws(ImageRepositoryError) -> URL {
        let url: URL
        do {
            url = try await fileStorageService.url(for: filename)
        } catch let error {
            throw .unknown(error)
        }

        return url
    }

}
