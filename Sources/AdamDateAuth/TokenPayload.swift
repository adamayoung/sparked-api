//
//  TokenPayload.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import JWT

package struct TokenPayload: JWT.JWTPayload, Equatable {

    package let issuer: IssuerClaim
    package let audience: AudienceClaim
    package let subject: SubjectClaim
    package let email: String
    package let name: String
    package let expiration: ExpirationClaim

    package func verify(using algorithm: some JWTAlgorithm) async throws {
        //        guard issuer.value == Self.configuration.issuer else {
        //            throw JWTError.claimVerificationFailure(
        //                failedClaim: issuer,
        //                reason: "not intended for \(issuer.value)"
        //            )
        //        }
        //
        //        try audience.verifyIntendedAudience(includes: Self.configuration.audience)
        try expiration.verifyNotExpired()
    }

}

extension TokenPayload {

    package init(
        subject: String,
        email: String,
        fullName: String,
        configuration: JWTConfiguration,
        dateProvider: () -> Date = { Date.now }
    ) {
        let expirationDate = dateProvider().addingTimeInterval(configuration.expiration)

        self.init(
            issuer: IssuerClaim(value: configuration.issuer),
            audience: AudienceClaim(value: [configuration.audience]),
            subject: SubjectClaim(value: subject),
            email: email,
            name: fullName,
            expiration: ExpirationClaim(value: expirationDate)
        )
    }

}

extension TokenPayload {

    private enum CodingKeys: String, CodingKey {
        case issuer = "iss"
        case audience = "aud"
        case subject = "sub"
        case email
        case name
        case expiration = "exp"
    }

}
