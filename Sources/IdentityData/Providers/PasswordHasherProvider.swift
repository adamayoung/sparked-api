//
//  PasswordHasherProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package protocol PasswordHasherProvider: Sendable {

    func hash(_ password: String) throws -> String

    func verify(_ password: String, created digest: String) throws -> Bool

}
