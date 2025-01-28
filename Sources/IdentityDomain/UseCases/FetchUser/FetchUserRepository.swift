//
//  FetchUserRepository.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityEntities

package protocol FetchUserRepository {

    func fetch(byID id: User.ID) async throws(FetchUserError) -> User

}
