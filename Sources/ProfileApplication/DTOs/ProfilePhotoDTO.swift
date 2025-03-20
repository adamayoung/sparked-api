//
//  ProfilePhotoDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation

package struct ProfilePhotoDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let index: Int
    package let url: URL

    package var isLocalFile: Bool {
        url.absoluteString.hasPrefix("./")
    }

}
