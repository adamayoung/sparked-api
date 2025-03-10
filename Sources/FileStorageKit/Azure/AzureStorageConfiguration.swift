//
//  AzureStorageConfiguration.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation

package struct AzureStorageConfiguration: Sendable, Equatable {

    package let accountName: String
    package let accountKey: String

    package init(accountName: String, accountKey: String) {
        self.accountName = accountName
        self.accountKey = accountKey
    }

}
