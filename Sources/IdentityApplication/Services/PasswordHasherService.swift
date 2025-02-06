//
//  PasswordHasherProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package protocol PasswordHasherService: Sendable {

    func hash(_ password: String) throws -> String

    func verify(_ password: String, created digest: String) throws -> Bool

}
