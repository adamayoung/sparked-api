//
//  AdamDateAuthContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import AdamDateAuth
import Foundation

final class AdamDateAuthContainerConfigurator: ContainerConfigurator {

    private let jwtConfiguration: JWTConfiguration

    init(jwtConfiguration: JWTConfiguration) {
        self.jwtConfiguration = jwtConfiguration
    }

    func configure(in c: Container) {
        c.register(type: JWTConfiguration.self) { [jwtConfiguration] _ in
            jwtConfiguration
        }
    }

}
