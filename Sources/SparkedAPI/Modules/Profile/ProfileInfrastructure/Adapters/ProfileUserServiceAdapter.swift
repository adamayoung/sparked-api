//
//  ProfileUserServiceAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import IdentityApplication
import ProfileDomain
import ProfileInfrastructure

final class ProfileUserServiceAdapter: UserService {

    private let fetchUserUseCase: any FetchUserUseCase

    init(fetchUserUseCase: some FetchUserUseCase) {
        self.fetchUserUseCase = fetchUserUseCase
    }

    func fetch(
        byID id: ProfileDomain.User.ID
    ) async throws(UserServiceError) -> ProfileDomain.User {
        let identityUserDTO: IdentityApplication.UserDTO
        do {
            identityUserDTO = try await fetchUserUseCase.execute(id: id)
        } catch FetchUserError.notFoundByID {
            throw .notFound(userID: id)
        } catch let error {
            throw .unknown(error)
        }

        let user = ProfileUserMapper.map(from: identityUserDTO)

        return user
    }

}
