//
//  AddProfilePhotoUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation
import ProfileDomain

package protocol AddProfilePhotoUseCase {

    func execute(input: AddProfilePhotoInput) async throws(AddProfilePhotoError) -> ProfilePhotoDTO

}
