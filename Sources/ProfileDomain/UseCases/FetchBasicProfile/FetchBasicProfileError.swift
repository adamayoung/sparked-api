//
//  FetchBasicProfileError.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum FetchBasicProfileError: Error {

    case notFound
    case userNotFound(UUID)
    case unknown(Error)

}
