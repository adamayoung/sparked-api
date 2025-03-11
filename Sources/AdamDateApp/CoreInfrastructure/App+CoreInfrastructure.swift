//
//  App+CoreInfrastructure.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import AuthKit
import CacheKit
import FileStorageKit
import Vapor

extension Application {

    var cacheStore: any CacheStore {
        CacheFactory.makeInMemoryCacheStore()
    }

    var fileStorage: any FileStorage {
        if let azureStorageConfiguration {
            return FileStorageFactory.makeAzureFileStorage(
                configuration: azureStorageConfiguration,
                client: self.client
            )
        }

        return FileStorageFactory.makeLocalFileStorage(fileIO: self.fileio)
    }

    var passwordHasher: any AuthKit.PasswordHasher {
        AuthFactory.makePasswordHasher(vaporPasswordHasher: self.password)
    }

}
