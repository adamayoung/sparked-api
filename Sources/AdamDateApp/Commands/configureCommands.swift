//
//  configureCommands.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateCommands
import Vapor

func configureCommands(on app: Application) {
    app.commandUseCases.use(.default)

    app.asyncCommands.use(CommandFactory.makeCreateUserCommand(), as: "createuser")

    if app.environment == .development {
        app.asyncCommands.use(CommandFactory.makeSeedCommand(), as: "seed")
    }
}
