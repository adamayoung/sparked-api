//
//  FetchUserUseCase.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol FetchUserUseCase {

    func execute(id: User.ID) async throws(FetchUserError) -> User

}
