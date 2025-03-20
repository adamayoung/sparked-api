//
//  Application+IdentityInfrastructure.swift
//  SparkedAPI
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
            database: self.db(DatabaseID.sparked)
        )
    }

    var roleRepository: any RoleRepository {
        IdentityInfrastructureFactory.makeRoleRepository(
            database: self.db(DatabaseID.sparked)
        )
    }

    var passwordHasherService: any PasswordHasherService {
        IdentityAdapterFactory.makePasswordHasherService(
            hasher: self.passwordHasher
        )
    }

}
