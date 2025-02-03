//
//  FetchBasicProfileRepository.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol FetchBasicProfileRepository {

    func fetch(byID id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile

    func fetch(byUserID userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile

}
