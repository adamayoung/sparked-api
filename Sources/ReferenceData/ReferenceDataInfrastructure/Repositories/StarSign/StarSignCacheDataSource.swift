//
//  StarSignCacheDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol StarSignCacheDataSource: Sendable {

    func fetchAll() async throws(StarSignRepositoryError) -> [StarSign]?

    func setStarSigns(_ starSigns: [StarSign]) async throws(StarSignRepositoryError)

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign?

    func setStarSign(_ starSign: StarSign) async throws(StarSignRepositoryError)

}
