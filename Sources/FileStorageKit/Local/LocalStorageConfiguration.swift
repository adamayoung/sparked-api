//
//  LocalStorageConfiguration.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package struct LocalStorageConfiguration: Sendable, Equatable {

    package let path: String

    package init(path: String) {
        self.path = path
    }

}
