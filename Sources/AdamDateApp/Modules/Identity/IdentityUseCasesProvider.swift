//
//  IdentityUseCasesProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Fluent
import Foundation
import IdentityApplication
import IdentityDomain
import IdentityInfrastructure
import IdentityPresentation
import Vapor

extension Application.IdentityUseCases.Provider {

    static var `default`: Self {
        Self { app in
            app.identityUseCases.use { app in
                IdentityApplicationFactory.makeFetchUserUseCase(
                    repository: app.userRepository
                )
            }

            app.identityUseCases.use { app in
                IdentityApplicationFactory.makeRegisterUserUseCase(
                    repository: app.userRepository,
                    hasher: app.passwordHasherService
                )
            }

            app.identityUseCases.use { app in
                IdentityApplicationFactory.makeAuthenticateUserUseCase(
                    repository: app.userRepository,
                    hasher: app.passwordHasherService
                )
            }
        }
    }

}

extension Application {

    var userRepository: any UserRepository {
        IdentityInfrastructureFactory.makeUserRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var passwordHasherService: any PasswordHasherService {
        IdentityAdapterFactory.makePasswordHasherService(
            hasher: self.passwordHasher
        )
    }

}
