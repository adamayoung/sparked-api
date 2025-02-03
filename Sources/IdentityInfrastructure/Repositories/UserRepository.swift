//
//  UserRepository.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain

package protocol UserRepository: RegisterUserRepository, FetchUserRepository,
    AuthenticateUserRepository, Sendable
{}
