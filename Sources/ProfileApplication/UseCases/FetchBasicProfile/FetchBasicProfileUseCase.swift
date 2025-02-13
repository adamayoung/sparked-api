//
//  FetchBasicProfileUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol FetchBasicProfileUseCase {

    func execute(id: UUID) async throws(FetchBasicProfileError) -> BasicProfileDTO

    func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfileDTO

}
