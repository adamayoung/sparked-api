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
        c.register(type: Database.self, name: DatabaseID.identity.string) { [database] _ in
            database
        }

        c.register(type: UserRemoteDataSource.self) { c in
            UserFluentRemoteDataSource(
                database: c.resolve(Database.self, name: DatabaseID.identity.string),
                passwordHasher: c.resolve(PasswordHasherProvider.self)
            )
        }

        c.register(type: UserRepository.self) { c in
            UserDefaultRepository(
                remoteDataSource: c.resolve(UserRemoteDataSource.self)
            )
        }
    }

    private func configureApplication(in c: Container) {
        c.register(type: TokenPayloadProvider.self) { c in
            TokenPayloadAdapter(jwtConfiguration: c.resolve(JWTConfiguration.self))
        }

        c.register(type: PasswordHasherProvider.self) { [passwordHasher] _ in
            PasswordHasherAdapter(hasher: passwordHasher)
        }

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

    private func configurePresentation(in c: Container) {
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
