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
    private let roleRepository: any RoleRepository

    init(
        repository: some UserRepository,
        roleRepository: some RoleRepository
    ) {
        self.repository = repository
        self.roleRepository = roleRepository
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

        let roles: [Role]
        do {
            roles = try await roleRepository.fetchAll(forUserID: user.id)
        } catch RoleRepositoryError.userNotFound {
            throw .notFoundByID(userID: id)
        } catch let error {
            throw .unknown(error)
        }

        let userDTO = UserDTOMapper.map(from: user, roles: roles)

        return userDTO
    }

}
