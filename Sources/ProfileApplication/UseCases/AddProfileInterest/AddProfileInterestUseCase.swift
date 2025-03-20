//
//  AddProfileInterestUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package protocol AddProfileInterestUseCase {

    func execute(
        input: AddProfileInterestInput,
        userContext: some UserContext
    ) async throws(AddProfileInterestError) -> ProfileInterestDTO

}
