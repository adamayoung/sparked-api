//
//  BasicProfileMockRepository.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileDomain

package final class BasicProfileMockRepository: BasicProfileRepository {

    private static let store = ProfileStore()

    package init() {}

    package func create(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile {
        guard await Self.store.get(byUserID: input.userID) == nil else {
            throw .profileAlreadyExistsForUser(userID: input.userID)
        }

        let id = UUID()
        let profile = BasicProfile(
            id: id,
            userID: input.userID,
            displayName: input.displayName,
            birthDate: input.birthDate
        )

        await Self.store.add(profile: profile)

        return profile
    }

    package func fetch(byID id: BasicProfile.ID) async throws(FetchBasicProfileError)
        -> BasicProfile
    {
        guard let profile = await Self.store.get(byID: id) else {
            throw .notFound(profileID: id)
        }

        return profile
    }

    package func fetch(byUserID userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile {
        guard let profile = await Self.store.get(byUserID: userID) else {
            throw .userNotFound(userID: userID)
        }

        return profile
    }

}

private actor ProfileStore {

    private var profiles: [BasicProfile.ID: BasicProfile] = [:]

    init() {}

    func add(profile: BasicProfile) async {
        profiles[profile.id] = profile
    }

    func get(byID id: BasicProfile.ID) async -> BasicProfile? {
        profiles[id]
    }

    func get(byUserID userID: UUID) async -> BasicProfile? {
        profiles.first { $0.value.userID == userID }?.value
    }

}
