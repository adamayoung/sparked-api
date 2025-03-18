//
//  ProfileInterestRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

protocol ProfileInterestRemoteDataSource {

    func create(_ profileInterest: ProfileInterest) async throws(ProfileInterestRepositoryError)

    func fetchAll(
        forProfileID profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> [ProfileInterest]

    func fetch(
        byID id: ProfileInterest.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest

    func fetch(
        byInterestID interestID: Interest.ID,
        for profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest

    func delete(id: ProfileInterest.ID) async throws(ProfileInterestRepositoryError)

}
