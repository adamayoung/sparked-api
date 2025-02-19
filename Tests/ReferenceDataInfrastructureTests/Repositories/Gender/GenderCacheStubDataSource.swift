//
//  GenderCacheStubDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

@testable import ReferenceDataInfrastructure

final class GenderCacheStubDataSource: GenderCacheDataSource {

    init() {}

    func fetchAll() async throws(GenderRepositoryError) -> [Gender]? {
        nil
    }

    func setGenders(_ countries: [Gender]) async throws(GenderRepositoryError) {
    }

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender? {
        nil
    }

    func setGender(_ country: Gender) async throws(GenderRepositoryError) {
    }

}
