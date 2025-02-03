//
//  TokenPayloadProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import AdamDateAuth
import Foundation
import IdentityDomain

package protocol TokenPayloadProvider: Sendable {

    func tokenPayload(for user: User) -> TokenPayload

}
