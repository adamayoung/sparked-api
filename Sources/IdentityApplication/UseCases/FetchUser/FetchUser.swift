//
//  FetchUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain

final class FetchUser: FetchUserUseCase {

    private let repository: any UserRepository

    init(repository: some UserRepository) {
        self.repository = repository
    }

    func execute(id: User.ID) async throws(FetchUserError) -> UserDTO {
        let user: User
        do {
            user = try await repository.fetch(byID: id)
        } catch UserRepositoryError.notFound {
            throw .notFoundByID(userID: id)
        } catch let error {
            throw .unknown(error)
        }

        let userDTO = UserDTOMapper.map(from: user)

        return userDTO
    }

}
