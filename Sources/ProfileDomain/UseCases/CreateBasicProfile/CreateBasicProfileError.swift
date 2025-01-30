//
//  CreateBasicProfileError.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

package enum CreateBasicProfileError: Error {

    case userNotFound
    case profileAlreadyExistsForUser
    case unknown(Error? = nil)

}
