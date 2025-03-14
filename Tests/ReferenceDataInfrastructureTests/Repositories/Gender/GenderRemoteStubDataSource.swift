//
//  GenderRemoteStubDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

@testable import ReferenceDataInfrastructure

@MainActor
final class GenderRemoteStubDataSource: GenderRemoteDataSource {

    var fetchAllResult: Result<[Gender], GenderRepositoryError> = .failure(.unknown())
    private(set) var fetchAllWasCalled = false

    var fetchByIDResult: Result<Gender, GenderRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: Gender.ID?

    init() {}

    func fetchAll() async throws(GenderRepositoryError) -> [Gender] {
        fetchAllWasCalled = true
        return try fetchAllResult.get()
    }

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender {
        fetchByIDWasCalled = true
        lastFetchByIDID = id
        return try fetchByIDResult.get()
    }

}
