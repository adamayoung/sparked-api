//
//  GenderStubService.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileApplication

final class GenderStubService: GenderService {

    var doesGenderExistResult: Result<Bool, GenderServiceError> = .success(true)
    private(set) var doesGenderExistWasCalled = false
    private(set) var lastDoesGenderExistWithIDID: UUID?

    func doesGenderExist(withID id: UUID) async throws(GenderServiceError) -> Bool {
        doesGenderExistWasCalled = true
        lastDoesGenderExistWithIDID = id
        return try doesGenderExistResult.get()
    }

}
