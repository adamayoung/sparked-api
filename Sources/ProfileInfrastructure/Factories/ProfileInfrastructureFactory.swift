//
//  ProfileInfrastructureFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Fluent
import Foundation
import ProfileApplication

package final class ProfileInfrastructureFactory: Sendable {

    private init() {}

    package static func makeBasicProfileRepository(
        database: some Database
    ) -> some BasicProfileRepository {
        let remoteDataSource = Self.makeBasicProfileRemoteDataSource(database: database)

        return BasicProfileDefaultRepository(remoteDataSource: remoteDataSource)
    }

    package static func makeBasicInfoRepository(
        database: some Database
    ) -> some BasicInfoRepository {
        let remoteDataSource = Self.makeBasicInfoRemoteDataSource(database: database)

        return BasicInfoDefaultRepository(remoteDataSource: remoteDataSource)
    }

    package static func makeProfilePhotoRepository(
        database: some Database
    ) -> some ProfilePhotoRepository {
        let remoteDataSource = Self.makeProfilePhotoRemoteDataSource(database: database)

        return ProfilePhotoDefaultRepository(remoteDataSource: remoteDataSource)
    }

    package static func makeImageRepository(
        fileStorageService: some FileStorageService
    ) -> some ImageRepository {
        let remoteDataSource = Self.makeImageRemoteDataSource(fileStorageService: fileStorageService)

        return ImageDefaultRepository(remoteDataSource: remoteDataSource)
    }

    package static func makeMigrations() -> [Migration] {
        ProfileMigrations.all()
    }

}

extension ProfileInfrastructureFactory {

    private static func makeBasicProfileRemoteDataSource(
        database: some Database
    ) -> some BasicProfileRemoteDataSource {
        BasicProfileRemoteFluentDataSource(database: database)
    }

    private static func makeBasicInfoRemoteDataSource(
        database: some Database
    ) -> some BasicInfoRemoteDataSource {
        BasicInfoRemoteFluentDataSource(database: database)
    }

    private static func makeProfilePhotoRemoteDataSource(
        database: some Database
    ) -> some ProfilePhotoRemoteDataSource {
        ProfilePhotoRemoteFluentDataSource(database: database)
    }

    private static func makeImageRemoteDataSource(
        fileStorageService: some FileStorageService
    ) -> some ImageRemoteDataSource {
        ImageRemoteStorageDataSource(fileStorageService: fileStorageService)
    }

}
