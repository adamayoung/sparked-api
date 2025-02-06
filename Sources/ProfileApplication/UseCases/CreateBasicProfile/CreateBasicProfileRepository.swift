//
//  CreateProfileRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileDomain

package protocol CreateBasicProfileRepository {

    func create(_ basicProfile: BasicProfile) async throws(CreateBasicProfileError)

}
