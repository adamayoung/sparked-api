//
//  ChangeProfilePhotoOrderUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation
import ProfileDomain

package protocol ChangeProfilePhotoOrderUseCase {

    func execute(
        input: ChangeProfilePhotoOrderInput
    ) async throws(ChangeProfilePhotoOrderError) -> ProfilePhotoDTO

}
