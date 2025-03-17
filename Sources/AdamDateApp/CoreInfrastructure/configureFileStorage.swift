//
//  configureFileStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import FileStorageKit
import Vapor

func configureFileStorage(on app: Application) {
    if let azureConfiguration = azureFileStorageConfiguration(on: app) {
        app.fileStorageConfiguration = azureConfiguration
    } else {
        app.fileStorageConfiguration = localFileStorageConfiguration(on: app)
    }

    app.logger.info("File storage: \(app.fileStorageConfiguration?.description ?? "Not set")")
}

private func azureFileStorageConfiguration(on app: Application) -> FileStorageConfiguration? {
    guard
        let accountName = Environment.get("AZURE_STORAGE_ACCOUNT_NAME"),
        let accountKey = Environment.get("AZURE_STORAGE_ACCOUNT_KEY"),
        !accountName.isEmpty,
        !accountKey.isEmpty
    else {
        return nil
    }

    let configuration = AzureStorageConfiguration(
        accountName: accountName,
        accountKey: accountKey
    )
    return .azure(configuration)
}

private func localFileStorageConfiguration(on app: Application) -> FileStorageConfiguration {
    let path = {
        guard
            let envPath = Environment.get("LOCAL_FILE_STORAGE_PATH"),
            !envPath.isEmpty
        else {
            return "./.storage"
        }

        return envPath
    }()

    let configuration = LocalStorageConfiguration(path: path)
    return .local(configuration)
}

struct FileStorageConfigurationKey: StorageKey {
    typealias Value = FileStorageConfiguration
}

extension Application {

    var fileStorageConfiguration: FileStorageConfiguration? {
        get {
            self.storage[FileStorageConfigurationKey.self]
        }
        set {
            self.storage[FileStorageConfigurationKey.self] = newValue
        }
    }

}
