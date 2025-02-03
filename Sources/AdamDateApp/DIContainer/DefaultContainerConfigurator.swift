//
//  DefaultContainerConfigurator.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateAuth
import Fluent
import Foundation
import IdentityAPI
import IdentityDomain
import IdentityInfrastructure
import ProfileAPI
import ProfileDomain
import ProfileInfrastructure
import Vapor

final class DefaultContainerConfigurator: ContainerConfigurator {

    private let c: Container
    private let databases: [DatabaseID: Database]
    private let jwtConfiguration: JWTConfiguration
    private let passwordHasher: PasswordHasher

    init(
        container: Container,
        databases: [DatabaseID: Database],
        jwtConfiguration: JWTConfiguration,
        passwordHasher: PasswordHasher
    ) {
        self.c = container
        self.databases = databases
        self.jwtConfiguration = jwtConfiguration
        self.passwordHasher = passwordHasher
    }

    func configure() {
        configureDatabases()
        configureAuth()
        configureProviders()
        configureRepositories()
        configureUseCases()
        configureControllers()
    }

}

extension DefaultContainerConfigurator {

    private func configureDatabases() {
        for (id, database) in databases {
            c.register(type: Database.self, name: id.string) { _ in
                database
            }
        }
    }

    private func configureAuth() {
        c.register(type: JWTConfiguration.self) { _ in
            self.jwtConfiguration
        }

        c.register(type: TokenPayloadProvider.self) { c in
            TokenPayloadAdapter(jwtConfiguration: c.resolve(JWTConfiguration.self))
        }
    }

    private func configureProviders() {
        c.register(type: PasswordHasherProvider.self) { _ in
            PasswordHasherAdapter(hasher: self.passwordHasher)
        }
    }

    private func configureRepositories() {
        c.register(type: UserRepository.self) { c in
            UserFluentRepository(
                database: c.resolve(Database.self, name: DatabaseID.identity.string),
                passwordHasher: c.resolve(PasswordHasherProvider.self)
            )
        }

        c.register(type: BasicProfileRepository.self) { c in
            BasicProfileFluentRepository(
                database: c.resolve(Database.self, name: DatabaseID.profile.string)
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

        c.register(type: CreateBasicProfileUseCase.self) { c in
            CreateBasicProfile(
                repository: c.resolve(BasicProfileRepository.self)
            )
        }

        c.register(type: FetchBasicProfileUseCase.self) { c in
            FetchBasicProfile(repository: c.resolve(BasicProfileRepository.self))
        }
    }

    private func configureControllers() {
        c.register(type: BasicProfileController.self) { c in
            BasicProfileController(
                createBasicProfileUseCase: { c.resolve(CreateBasicProfileUseCase.self) },
                fetchBasicProfileUseCase: { c.resolve(FetchBasicProfileUseCase.self) }
            )
        }

        c.register(type: AuthController.self) { c in
            AuthController(
                registerUserUseCase: { c.resolve(RegisterUserUseCase.self) },
                authenticateUserUseCase: { c.resolve(AuthenticateUserUseCase.self) },
                fetchUserUseCase: { c.resolve(FetchUserUseCase.self) },
                tokenPayloadProvider: { c.resolve(TokenPayloadProvider.self) }
            )
        }
    }

}
