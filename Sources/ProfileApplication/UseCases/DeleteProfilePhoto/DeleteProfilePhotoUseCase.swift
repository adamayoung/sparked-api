//
//  DeleteProfilePhotoUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import ProfileDomain

package protocol DeleteProfilePhotoUseCase {

    func execute(input: DeleteProfilePhotoInput) async throws(DeleteProfilePhotoError)

}
