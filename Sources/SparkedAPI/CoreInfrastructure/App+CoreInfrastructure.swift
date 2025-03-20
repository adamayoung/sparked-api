//
//  App+CoreInfrastructure.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/03/2025.
//

import AuthKit
import CacheKit
import FileStorageKit
import Vapor

extension Application {

    var cacheStore: any CacheStore {
        CacheFactory.makeInMemoryCacheStore(logger: self.logger)
    }

    var fileStorage: any FileStorage {
        guard let fileStorageConfiguration else {
            fatalError("No storage configuration found")
        }

        switch fileStorageConfiguration {
        case .azure(let azureStorageConfiguration):
            return FileStorageFactory.makeAzureFileStorage(
                configuration: azureStorageConfiguration,
                client: self.client
            )
        case .local(let localStorageConfiguration):
            return FileStorageFactory.makeLocalFileStorage(
                configuration: localStorageConfiguration,
                fileIO: self.fileio
            )
        }
    }

    var passwordHasher: any AuthKit.PasswordHasher {
        AuthFactory.makePasswordHasher(vaporPasswordHasher: self.password)
    }

}
