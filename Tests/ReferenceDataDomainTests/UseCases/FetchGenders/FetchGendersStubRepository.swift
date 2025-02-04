//
//  FetchGendersStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchGendersStubRepository: FetchGendersRepository {

    var gendersResult: Result<[Gender], FetchGendersError> = .failure(.unknown())
    private(set) var gendersHasBeenCalled = false

    init() {}

    func genders() async throws(FetchGendersError) -> [Gender] {
        gendersHasBeenCalled = true
        return try gendersResult.get()
    }

}
