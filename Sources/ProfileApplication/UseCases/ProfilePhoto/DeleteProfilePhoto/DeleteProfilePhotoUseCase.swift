//
//  DeleteProfilePhotoUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/03/2025.
//

import ProfileDomain

package protocol DeleteProfilePhotoUseCase {

    func execute(
        input: DeleteProfilePhotoInput,
        userContext: some UserContext
    ) async throws(DeleteProfilePhotoError)

}
