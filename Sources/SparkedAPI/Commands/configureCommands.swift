//
//  configureCommands.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import SparkedCommands
import Vapor

func configureCommands(on app: Application) {
    app.commandUseCases.use(.default)

    app.asyncCommands.use(CommandFactory.makeCreateUserCommand(), as: "create-user")

    if app.environment == .development {
        app.asyncCommands.use(CommandFactory.makeSeedCommand(), as: "seed")
    }
}
