//
//  FetchUserUseCase.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityEntities

package protocol FetchUserUseCase {

    func execute(id: User.ID) async throws(FetchUserError) -> User

}
