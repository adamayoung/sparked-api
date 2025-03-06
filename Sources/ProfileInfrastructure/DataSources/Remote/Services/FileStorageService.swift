//
//  FileStorageService.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileDomain

package protocol FileStorageService {

    func save(_ data: Data, filename: String) async throws

    func url(for filename: String) async throws -> URL

}
