//
//  FetchProfilePhotoUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation

package protocol FetchProfilePhotoUseCase {

    func execute(id: UUID) async throws(FetchProfilePhotoError) -> ProfilePhotoDTO

}
