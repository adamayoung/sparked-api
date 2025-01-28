//
//  JWTConfiguration.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package struct JWTConfiguration {

    package let issuer: String
    package let audience: String
    package let expiration: TimeInterval

    package init(
        issuer: String,
        audience: String,
        expiration: TimeInterval
    ) {
        self.issuer = issuer
        self.audience = audience
        self.expiration = expiration
    }

}
