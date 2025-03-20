//
//  CommandFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/02/2025.
//

import Vapor

package final class CommandFactory {

    private init() {}

    package static func makeCreateUserCommand() -> some AsyncCommand {
        CreateUserCommand()
    }

    package static func makeSeedCommand() -> some AsyncCommand {
        SeedCommand()
    }

}
