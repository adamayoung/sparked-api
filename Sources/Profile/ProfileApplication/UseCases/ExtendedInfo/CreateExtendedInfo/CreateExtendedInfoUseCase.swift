//
//  CreateExtendedInfoUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package protocol CreateExtendedInfoUseCase {

    func execute(
        input: CreateExtendedInfoInput,
        userContext: some UserContext
    ) async throws(CreateExtendedInfoError) -> ExtendedInfoDTO

}
