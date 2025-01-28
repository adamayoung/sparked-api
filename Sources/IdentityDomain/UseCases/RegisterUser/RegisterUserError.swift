//
//  RegisterUserError.swift
//  AdamDateDomain
//
//  Created by Adam Young on 09/01/2025.
//

package enum RegisterUserError: Error {

    case emailAlreadyExists
    case unknown(Error)

}
