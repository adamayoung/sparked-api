//
//  configureAuth.swift
//  SparkedAPI
//
//  Created by Adam Young on 28/01/2025.
//

import AuthKit
import IdentityDomain
import JWT
import Vapor

func configureAuth(on app: Application) async {
    guard
        let secret = Environment.get("JWT_SECRET"),
        let expirationString = Environment.get("JWT_EXPIRATION"),
        let expiration = TimeInterval(expirationString),
        let issuer = Environment.get("JWT_ISSUER"),
        let audience = Environment.get("JWT_AUDIENCE")
    else {
        fatalError("Missing required JWT environment variables")
    }

    let hmac = HMACKey(from: secret)
    await app.jwt.keys.add(hmac: hmac, digestAlgorithm: .sha256)

    let jwtConfiguration = JWTConfiguration(
        issuer: issuer,
        audience: audience,
        expiration: expiration
    )

    app.passwords.use(.bcrypt)

    app.jwtConfiguration = jwtConfiguration
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
