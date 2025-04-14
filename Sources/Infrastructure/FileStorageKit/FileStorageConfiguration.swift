//
//  FileStorageConfiguration.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation

package enum FileStorageConfiguration: CustomStringConvertible {

    case local(LocalStorageConfiguration)
    case azure(AzureStorageConfiguration)

    package var description: String {
        switch self {
        case .local(let config):
            return "Local (path: \(config.path))"

        case .azure(let config):
            return "Azure (accountName: \(config.accountName))"
        }
    }

}
