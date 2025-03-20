//
//  ProfilePhotoRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileDomain

package protocol ProfilePhotoRepository {

    func create(_ profilePhoto: ProfilePhoto) async throws(ProfilePhotoRepositoryError)

    func fetchAll(
        forProfileID profileID: BasicProfile.ID
    ) async throws(ProfilePhotoRepositoryError) -> [ProfilePhoto]

    func fetch(byID id: ProfilePhoto.ID) async throws(ProfilePhotoRepositoryError) -> ProfilePhoto

    func update(profilePhotos: [ProfilePhoto]) async throws(ProfilePhotoRepositoryError)

    func delete(id: ProfilePhoto.ID) async throws(ProfilePhotoRepositoryError)

}

package enum ProfilePhotoRepositoryError: Error, Equatable {

    case duplicate
    case notFound
    case unknown(Error? = nil)

    package static func == (
        lhs: ProfilePhotoRepositoryError,
        rhs: ProfilePhotoRepositoryError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.duplicate, .duplicate):
            return true
        case (.notFound, .notFound):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }

}
