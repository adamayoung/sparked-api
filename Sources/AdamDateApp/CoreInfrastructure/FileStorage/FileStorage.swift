//
//  FileStorage.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation

protocol FileStorage {

    func write(data: Data, to path: String) async throws

    func url(for path: String) async throws -> URL

}
