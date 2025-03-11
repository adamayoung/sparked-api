//
//  configureFileStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import FileStorageKit
import Vapor

func configureFileStorage(on app: Application) throws {
    guard
        let accountName = Environment.get("AZURE_STORAGE_ACCOUNT_NAME"),
        let accountKey = Environment.get("AZURE_STORAGE_ACCOUNT_KEY"),
        !accountName.isEmpty,
        !accountKey.isEmpty
    else {
        app.logger.info("Using local file storage")
        return
    }

    let azureStorageConfiguration = AzureStorageConfiguration(
        accountName: accountName,
        accountKey: accountKey
    )

    app.logger.info("Using Azure file storage")

    app.azureStorageConfiguration = azureStorageConfiguration
}

struct AzureStorageConfigurationKey: StorageKey {
    typealias Value = AzureStorageConfiguration
}

extension Application {

    var azureStorageConfiguration: AzureStorageConfiguration? {
        get {
            self.storage[AzureStorageConfigurationKey.self]
        }
        set {
            self.storage[AzureStorageConfigurationKey.self] = newValue
        }
    }

}
