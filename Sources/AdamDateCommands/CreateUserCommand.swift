//
//  CreateUserCommand.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import IdentityDomain
import IdentityEntities
import Vapor

package struct CreateUserCommand: AsyncCommand {

    package struct Signature: CommandSignature {
        @Option(name: "firstName", short: "f")
        package var firstName: String?

        @Option(name: "lastName", short: "l")
        package var lastName: String?

        @Option(name: "email", short: "e")
        package var email: String?

        @Option(name: "password", short: "p")
        package var password: String?

        package init() {}
    }

    package var help: String {
        "Creates a user"
    }

    private let registerUserUseCase: @Sendable () -> any RegisterUserUseCase

    package init(
        registerUserUseCase: @escaping @Sendable () -> any RegisterUserUseCase
    ) {
        self.registerUserUseCase = registerUserUseCase
    }

    package func run(using context: CommandContext, signature: Signature) async throws {
        context.console.info("Creating user...")

        guard let firstName = signature.firstName else {
            context.console.error("Missing first name argument")
            return
        }

        guard let lastName = signature.lastName else {
            context.console.error("Missing last name argument")
            return
        }

        guard let email = signature.email else {
            context.console.error("Missing email argument")
            return
        }

        guard let password = signature.password else {
            context.console.error("Missing password argument")
            return
        }

        let registerUserInput = RegisterUserInput(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )

        let useCase = registerUserUseCase()
        let user = try await useCase.execute(input: registerUserInput)

        context.console.info("User created successfully: \(user)")
    }

}
