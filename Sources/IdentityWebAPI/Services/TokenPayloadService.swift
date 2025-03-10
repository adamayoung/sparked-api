//
//  TokenPayloadService.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import AuthKit
import Foundation
import IdentityApplication

package protocol TokenPayloadService: Sendable {

    func tokenPayload(for dto: UserDTO) -> TokenPayload

}
