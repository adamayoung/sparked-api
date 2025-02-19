//
//  IdentityServicesProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import AdamDateAuth
import Foundation
import IdentityPresentation
import Vapor

extension Application.IdentityServices.Provider {

    static var `default`: Self {
        Self { app in
            app.identityServices.use { app in
                IdentityAdapterFactory.makeTokenPayloadService(
                    jwtConfiguration: app.jwtConfiguration
                )
            }
        }

    }

}

struct JWTConfigurationKey: StorageKey {
    typealias Value = JWTConfiguration
}

extension Application {

    var jwtConfiguration: JWTConfiguration {
        get {
            guard let value = self.storage[JWTConfigurationKey.self] else {
                fatalError("jwtConfiguration not set")
            }

            return value
        }
        set {
            self.storage[JWTConfigurationKey.self] = newValue
        }
    }

}
