//
//  FetchBasicProfileUseCase.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol FetchBasicProfileUseCase {

    func execute(id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile

    func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile

}
