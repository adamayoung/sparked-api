//
//  FetchRoles.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityDomain

final class FetchRoles: FetchRolesUseCase {

    private let repository: any RoleRepository

    init(repository: some RoleRepository) {
        self.repository = repository
    }

    func execute() async throws(FetchRolesError) -> [RoleDTO] {
        let roles: [Role]
        do {
            roles = try await repository.fetchAll()
        } catch let error {
            throw .unknown(error)
        }

        let roleDTOs = roles.map(RoleDTOMapper.map)

        return roleDTOs
    }

}
