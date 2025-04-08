//
//  SeedCommand.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct SeedCommand: AsyncCommand {

    struct Signature: CommandSignature {}

    var help: String {
        "Seeds database with sample data"
    }

    init() {}

    func run(using context: CommandContext, signature _: Signature) async throws {
        context.console.info("Seeding database...")
    }

}
