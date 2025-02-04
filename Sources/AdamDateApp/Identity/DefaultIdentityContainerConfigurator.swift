//
//  DefaultIdentityContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import AdamDateAuth
import Fluent
import Foundation
import IdentityAPI
import IdentityDomain
import IdentityInfrastructure
import Vapor

final class DefaultIdentityContainerConfigurator: ContainerConfigurator {

    private let c: Container
    private let database: any Database
    private let passwordHasher: any PasswordHasher

    init(
        container: Container,
        database: any Database,
        passwordHasher: some PasswordHasher
    ) {
        self.c = container
        self.database = database
        self.passwordHasher = passwordHasher
    }

    func configure() {
        configureDatabase()
        configureProviders()
        configureRepositories()
        configureUseCases()
        configureControllers()
    }

}

extension DefaultIdentityContainerConfigurator {

    private func configureDatabase() {
        c.register(type: Database.self, name: DatabaseID.identity.string) { [database] _ in
            database
        }
    }

    private func configureProviders() {
        c.register(type: TokenPayloadProvider.self) { c in
            TokenPayloadAdapter(jwtConfiguration: c.resolve(JWTConfiguration.self))
        }

        c.register(type: PasswordHasherProvider.self) { [passwordHasher] _ in
            PasswordHasherAdapter(hasher: passwordHasher)
        }
    }

    private func configureRepositories() {
        c.register(type: UserRepository.self) { c in
            UserFluentRepository(
                database: c.resolve(Database.self, name: DatabaseID.identity.string),
                passwordHasher: c.resolve(PasswordHasherProvider.self)
            )
        }
    }

    private func configureUseCases() {
        c.register(type: RegisterUserUseCase.self) { c in
            RegisterUser(repository: c.resolve(UserRepository.self))
        }

        c.register(type: AuthenticateUserUseCase.self) { c in
            AuthenticateUser(repository: c.resolve(UserRepository.self))
        }

        c.register(type: FetchUserUseCase.self) { c in
            FetchUser(repository: c.resolve(UserRepository.self))
        }
    }

    private func configureControllers() {
        c.register(type: AuthController.self) { c in
            AuthController(
                registerUserUseCase: { [c] in c.resolve(RegisterUserUseCase.self) },
                authenticateUserUseCase: { [c] in c.resolve(AuthenticateUserUseCase.self) },
                fetchUserUseCase: { [c] in c.resolve(FetchUserUseCase.self) },
                tokenPayloadProvider: { [c] in c.resolve(TokenPayloadProvider.self) }
            )
        }
    }

}
