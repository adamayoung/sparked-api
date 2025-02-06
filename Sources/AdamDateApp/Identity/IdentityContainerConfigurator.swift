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

        c.register(type: UserRemoteDataSource.self) { c in
            UserFluentRemoteDataSource(
                database: c.resolve(Database.self, name: DatabaseID.identity.string)
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

        c.register(type: RegisterUserUseCase.self) { c in
            RegisterUser(
                repository: c.resolve(UserRepository.self),
                hasher: c.resolve(PasswordHasherService.self)
            )
        }

        c.register(type: AuthenticateUserUseCase.self) { c in
            AuthenticateUser(
                repository: c.resolve(UserRepository.self),
                hasher: c.resolve(PasswordHasherService.self)
            )
        }

        c.register(type: FetchUserUseCase.self) { c in
            FetchUser(repository: c.resolve(UserRepository.self))
        }
    }

    private func configurePresentation(in c: Container) {
        c.register(type: MeController.self) { c in
            let dependencies = MeController.Dependencies(
                fetchUserUseCase: { [c] in c.resolve(FetchUserUseCase.self) }
            )

            return MeController(dependencies: dependencies)
        }

        c.register(type: RegisterController.self) { c in
            let dependencies = RegisterController.Dependencies(
                registerUserUseCase: { [c] in c.resolve(RegisterUserUseCase.self) }
            )

            return RegisterController(dependencies: dependencies)
        }

        c.register(type: TokenController.self) { c in
            let dependencies = TokenController.Dependencies(
                authenticateUserUseCase: { [c] in c.resolve(AuthenticateUserUseCase.self) },
                tokenPayloadProvider: { [c] in c.resolve(TokenPayloadProvider.self) }
            )

            return TokenController(dependencies: dependencies)
        }
    }

}
