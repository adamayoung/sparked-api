//
//  ProfileUserServiceAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import IdentityApplication
import ProfileApplication

final class ProfileUserServiceAdapter: UserService {

    private let fetchUserUseCase: @Sendable () -> any FetchUserUseCase

    init(fetchUserUseCase: @escaping @Sendable () -> any FetchUserUseCase) {
        self.fetchUserUseCase = fetchUserUseCase
    }

    func doesUserExist(withID id: UUID) async throws(ProfileApplication.UserServiceError) -> Bool {
        do {
            _ = try await fetchUserUseCase().execute(id: id)
        } catch FetchUserError.notFoundByID {
            return false
        } catch let error {
            throw .unknown(error)
        }

        return true
    }

}
