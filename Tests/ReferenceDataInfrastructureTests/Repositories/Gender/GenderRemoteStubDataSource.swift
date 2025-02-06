//
//  GenderRemoteStubDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import ReferenceDataInfrastructure

final class GenderRemoteStubDataSource: GenderRemoteDataSource {

    var gendersResult: Result<[Gender], FetchGendersError> = .failure(.unknown())
    private(set) var gendersWasCalled = false

    init() {}

    func genders() async throws(FetchGendersError) -> [Gender] {
        gendersWasCalled = true

        return try gendersResult.get()
    }

}
