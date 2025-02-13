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

final class GenderRemoteStubDataSource: GenderRemoteDataSource {

    var fetchAllResult: Result<[Gender], FetchGendersError> = .failure(.unknown())
    private(set) var fetchAllWasCalled = false

    var fetchByIDResult: Result<Gender, FetchGenderError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: Gender.ID?

    init() {}

    func fetchAll() async throws(FetchGendersError) -> [Gender] {
        fetchAllWasCalled = true
        return try fetchAllResult.get()
    }

    func fetch(byID id: Gender.ID) async throws(FetchGenderError) -> Gender {
        fetchByIDWasCalled = true
        lastFetchByIDID = id
        return try fetchByIDResult.get()
    }

}
