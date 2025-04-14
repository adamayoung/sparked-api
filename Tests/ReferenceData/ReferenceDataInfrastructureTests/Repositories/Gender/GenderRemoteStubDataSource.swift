//
//  GenderRemoteStubDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

@testable import ReferenceDataInfrastructure

final class GenderRemoteStubDataSource: GenderRemoteDataSource, @unchecked Sendable {

    var fetchAllResult: Result<[Gender], GenderRepositoryError> = .failure(.unknown())
    private(set) var fetchAllWasCalled = false

    var fetchByIDResult: Result<Gender, GenderRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDParameter: Gender.ID?

    init() {}

    func fetchAll() async throws(GenderRepositoryError) -> [Gender] {
        fetchAllWasCalled = true

        return try fetchAllResult.get()
    }

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender {
        fetchByIDWasCalled = true
        lastFetchByIDParameter = id

        return try fetchByIDResult.get()
    }

}
