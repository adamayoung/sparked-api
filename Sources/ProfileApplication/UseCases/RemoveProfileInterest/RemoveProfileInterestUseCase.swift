//
//  RemoveProfileInterestUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import ProfileDomain

package protocol RemoveProfileInterestUseCase {

    func execute(
        input: RemoveProfileInterestInput,
        userContext: some UserContext
    ) async throws(RemoveProfileInterestError)

}
