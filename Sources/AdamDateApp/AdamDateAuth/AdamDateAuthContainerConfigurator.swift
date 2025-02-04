//
//  AdamDateAuthContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import AdamDateAuth
import Foundation

final class AdamDateAuthContainerConfigurator: ContainerConfigurator {

    private let c: Container
    private let jwtConfiguration: JWTConfiguration

    init(
        container: Container,
        jwtConfiguration: JWTConfiguration
    ) {
        self.c = container
        self.jwtConfiguration = jwtConfiguration
    }

    func configure() {
        c.register(type: JWTConfiguration.self) { [jwtConfiguration] _ in
            jwtConfiguration
        }
    }

}
