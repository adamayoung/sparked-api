//
//  ProfileInterestDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class ProfileInterestDefaultRepository: ProfileInterestRepository {

    private let remoteDataSource: any ProfileInterestRemoteDataSource

    init(remoteDataSource: some ProfileInterestRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ profileInterest: ProfileInterest) async throws(ProfileInterestRepositoryError) {
        try await remoteDataSource.create(profileInterest)
    }

    func fetchAll(
        forProfileID profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> [ProfileInterest] {
        try await remoteDataSource.fetchAll(forProfileID: profileID)
    }

    func fetch(
        byID id: ProfileInterest.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest {
        try await remoteDataSource.fetch(byID: id)
    }

    func fetch(
        byInterestID interestID: Interest.ID,
        for profileID: BasicProfile.ID
    ) async throws(ProfileInterestRepositoryError) -> ProfileInterest {
        try await remoteDataSource.fetch(byInterestID: interestID, for: profileID)
    }

    func delete(id: ProfileInterest.ID) async throws(ProfileInterestRepositoryError) {
        try await remoteDataSource.delete(id: id)
    }

}
