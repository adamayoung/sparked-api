//
//  FileStorageError.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation

package enum FileStorageError: Error {

    case invalidURL
    case notFound
    case network(Error)
    case unknown(Error? = nil)

}
