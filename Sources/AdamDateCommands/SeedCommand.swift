//
//  SeedCommand.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

package struct SeedCommand: AsyncCommand {

    package struct Signature: CommandSignature {
        package init() {}
    }

    package var help: String {
        "Seeds database with sample data"
    }

    package init() {}

    package func run(using context: CommandContext, signature _: Signature) async throws {
        context.console.info("Seeding database...")
    }

}
