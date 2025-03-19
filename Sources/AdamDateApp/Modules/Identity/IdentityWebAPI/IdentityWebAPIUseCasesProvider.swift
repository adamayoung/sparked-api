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
import IdentityWebAPI
import Vapor

extension Application.IdentityUseCases.Provider {

    static var `default`: Self {
        Self { app in
            app.identityUseCases.use { app in
                IdentityApplicationFactory.makeFetchUserUseCase(
                    repository: app.userRepository,
                    roleRepository: app.roleRepository
                )
            }

            app.identityUseCases.use { app in
                IdentityApplicationFactory.makeRegisterUserUseCase(
                    repository: app.userRepository,
                    roleRepository: app.roleRepository,
                    hasher: app.passwordHasherService
                )
            }

            app.identityUseCases.use { app in
                IdentityApplicationFactory.makeAuthenticateUserUseCase(
                    repository: app.userRepository,
                    roleRepository: app.roleRepository,
                    hasher: app.passwordHasherService
                )
            }
        }
    }

}
