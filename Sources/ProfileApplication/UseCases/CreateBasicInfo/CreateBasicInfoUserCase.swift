//
//  CreateBasicInfoUserCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation

package protocol CreateBasicInfoUseCase {

    func execute(
        input: CreateBasicInfoInput,
        userContext: some UserContext
    ) async throws(CreateBasicInfoError) -> BasicInfoDTO

}
