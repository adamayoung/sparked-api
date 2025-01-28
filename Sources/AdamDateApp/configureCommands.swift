//
//  configureCommands.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateCommands
import IdentityDomain
import Vapor

func configureCommands(_ app: Application, container: Container) {
    app.asyncCommands.use(
        CreateUserCommand(
            registerUserUseCase: { container.resolve(RegisterUserUseCase.self) }
        ),
        as: "createuser"
    )

    if app.environment == .development {
        app.asyncCommands.use(SeedCommand(), as: "seed")
    }
}
