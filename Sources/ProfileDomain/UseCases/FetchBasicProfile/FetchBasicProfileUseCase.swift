//
//  FetchBasicProfileUseCase.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileEntities

package protocol FetchBasicProfileUseCase: Sendable {

    func execute(id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile

    func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile

}
