//
//  ChangeProfilePhotoOrderUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation
import ProfileDomain

package protocol ChangeProfilePhotoOrderUseCase {

    func execute(
        input: ChangeProfilePhotoOrderInput,
        userContext: some UserContext
    ) async throws(ChangeProfilePhotoOrderError) -> ProfilePhotoDTO

}
