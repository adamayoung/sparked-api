//
//  StarSignRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol StarSignRemoteDataSource: Sendable {

    func fetchAll() async throws(StarSignRepositoryError) -> [StarSign]

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign

}
