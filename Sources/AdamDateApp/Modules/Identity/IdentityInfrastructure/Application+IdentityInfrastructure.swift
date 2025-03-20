//
//  Application+IdentityInfrastructure.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Fluent
import Foundation
import IdentityApplication
import IdentityInfrastructure
import Vapor

extension Application {

    var userRepository: any UserRepository {
        IdentityInfrastructureFactory.makeUserRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var roleRepository: any RoleRepository {
        IdentityInfrastructureFactory.makeRoleRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var passwordHasherService: any PasswordHasherService {
        IdentityAdapterFactory.makePasswordHasherService(
            hasher: self.passwordHasher
        )
    }

}
