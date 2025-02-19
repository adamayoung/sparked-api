//
//  GenderCacheDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol GenderCacheDataSource {

    func fetchAll() async throws(GenderRepositoryError) -> [Gender]?

    func setGenders(_ genders: [Gender]) async throws(GenderRepositoryError)

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender?

    func setGender(_ gender: Gender) async throws(GenderRepositoryError)

}
