//
//  GenderRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol GenderRemoteDataSource: Sendable {

    func fetchAll() async throws(GenderRepositoryError) -> [Gender]

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender

}
