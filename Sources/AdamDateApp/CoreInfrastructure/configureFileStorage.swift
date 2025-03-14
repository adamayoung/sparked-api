//
//  configureFileStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import FileStorageKit
import Vapor

func configureFileStorage(on app: Application) {
    let azureStorageConfigurationResult = configureAzureFileStorage(on: app)
    if azureStorageConfigurationResult {
        return
    }

    configureLocalFileStorage(on: app)
}

private func configureLocalFileStorage(on app: Application) {
    let path = {
        guard
            let envPath = Environment.get("LOCAL_FILE_STORAGE_PATH"),
            !envPath.isEmpty
        else {
            return "./.storage"
        }

        return envPath
    }()

    app.logger.info("Using local file storage at \(path)")

    let configuration = LocalStorageConfiguration(path: path)
    app.localStorageConfiguration = configuration
}

private func configureAzureFileStorage(on app: Application) -> Bool {
    guard
        let accountName = Environment.get("AZURE_STORAGE_ACCOUNT_NAME"),
        let accountKey = Environment.get("AZURE_STORAGE_ACCOUNT_KEY"),
        !accountName.isEmpty,
        !accountKey.isEmpty
    else {
        return false
    }

    app.logger.info("Using Azure file storage")

    let configuration = AzureStorageConfiguration(
        accountName: accountName,
        accountKey: accountKey
    )
    app.azureStorageConfiguration = configuration

    return true
}

struct LocalStorageConfigurationKey: StorageKey {
    typealias Value = LocalStorageConfiguration
}

struct AzureStorageConfigurationKey: StorageKey {
    typealias Value = AzureStorageConfiguration
}

extension Application {

    var localStorageConfiguration: LocalStorageConfiguration? {
        get {
            self.storage[LocalStorageConfigurationKey.self]
        }
        set {
            self.storage[LocalStorageConfigurationKey.self] = newValue
        }
    }

    var azureStorageConfiguration: AzureStorageConfiguration? {
        get {
            self.storage[AzureStorageConfigurationKey.self]
        }
        set {
            self.storage[AzureStorageConfigurationKey.self] = newValue
        }
    }

}
