//
//  ExtendedInfoRemoteDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

protocol ExtendedInfoRemoteDataSource {

    func create(_ extendedInfo: ExtendedInfo) async throws(ExtendedInfoRepositoryError)

    func fetch(byID id: ExtendedInfo.ID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo

    func fetch(byOwnerID ownerID: User.ID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo

    func fetch(
        byProfileID profileID: BasicProfile.ID
    ) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo

}
