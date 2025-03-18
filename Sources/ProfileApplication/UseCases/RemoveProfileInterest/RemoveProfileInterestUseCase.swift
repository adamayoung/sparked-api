//
//  RemoveProfileInterestUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import ProfileDomain

package protocol RemoveProfileInterestUseCase {

    func execute(input: RemoveProfileInterestInput) async throws(RemoveProfileInterestError)

}
