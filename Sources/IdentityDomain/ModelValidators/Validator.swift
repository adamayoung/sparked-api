//
//  Validator.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package protocol Validator {

    associatedtype Value
    associatedtype ValidatorError: Error & Sendable

    func validate(_ value: Value) throws(ValidatorError)

}
