//
//  BasicProfileRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

package protocol BasicProfileRemoteDataSource {

    func create(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile

    func fetch(byID id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile

    func fetch(byUserID userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile

}
