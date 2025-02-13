//
//  IdentityContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import AdamDateAuth
import Fluent
import Foundation
import IdentityApplication
import IdentityDomain
import IdentityInfrastructure
import IdentityPresentation
import Vapor

final class IdentityContainerConfigurator: ContainerConfigurator {

    private let database: any Database
    private let passwordHasher: any PasswordHasher

    init(
        database: any Database,
        passwordHasher: some PasswordHasher
    ) {
        self.database = database
        self.passwordHasher = passwordHasher
    }

    func configure(in c: Container) {
        configureInfrastructure(in: c)
        configureApplication(in: c)
        configurePresentation(in: c)
    }

}

extension IdentityContainerConfigurator {

    private func configureInfrastructure(in c: Container) {
        c.register(type: PasswordHasherService.self) { [passwordHasher] _ in
            PasswordHasherAdapter(hasher: passwordHasher)
        }

        c.register(type: Database.self, name: DatabaseID.identity.string) { [database] _ in
            database
        }

        c.register(type: UserRepository.self) { c in
            IdentityInfrastructureFactory.makeUserRepository(
                database: c.resolve(Database.self, name: DatabaseID.identity.string)
            )
        }
    }

    private func configureApplication(in c: Container) {
        c.register(type: TokenPayloadProvider.self) { c in
            TokenPayloadAdapter(jwtConfiguration: c.resolve(JWTConfiguration.self))
        }

        c.register(type: RegisterUserUseCase.self) { c in
            IdentityApplicationFactory.makeRegisterUserUseCase(
                repository: c.resolve(UserRepository.self),
                hasher: c.resolve(PasswordHasherService.self)
            )
        }

        c.register(type: AuthenticateUserUseCase.self) { c in
            IdentityApplicationFactory.makeAuthenticateUserUseCase(
                repository: c.resolve(UserRepository.self),
                hasher: c.resolve(PasswordHasherService.self)
            )
        }

        c.register(type: FetchUserUseCase.self) { c in
            IdentityApplicationFactory.makeFetchUserUseCase(
                repository: c.resolve(UserRepository.self)
            )
        }
    }

    private func configurePresentation(in c: Container) {
        c.register(type: RouteCollection.self, name: "MeController") { c in
            IdentityPresentationFactory.makeMeController(
                fetchUserUseCase: { [c] in c.resolve(FetchUserUseCase.self) }
            )
        }

        c.register(type: RouteCollection.self, name: "RegisterController") { c in
            IdentityPresentationFactory.makeRegisterController(
                registerUserUseCase: { [c] in c.resolve(RegisterUserUseCase.self) }
            )
        }

        c.register(type: RouteCollection.self, name: "TokenController") { c in
            IdentityPresentationFactory.makeTokenController(
                authenticateUserUseCase: { [c] in c.resolve(AuthenticateUserUseCase.self) },
                tokenPayloadProvider: { [c] in c.resolve(TokenPayloadProvider.self) }
            )
        }
    }

}
