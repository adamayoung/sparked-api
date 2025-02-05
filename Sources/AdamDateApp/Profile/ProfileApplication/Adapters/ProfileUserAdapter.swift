//
//  ProfileUserAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityApplication
import ProfileApplication

final class ProfileUserAdapter: UserService {

    private let fetchUserUseCase: any FetchUserUseCase

    init(fetchUserUseCase: some FetchUserUseCase) {
        self.fetchUserUseCase = fetchUserUseCase
    }

    func fetch(
        byID id: UUID
    ) async throws(ProfileApplication.UserServiceError) -> ProfileApplication.UserDTO {
        let userReference: IdentityApplication.UserDTO
        do {
            userReference = try await fetchUserUseCase.execute(id: id)
        } catch let error {
            throw .unknown(error)
        }

        let userDTO = UserDTOMapper.map(from: userReference)
        return userDTO
    }

}

private struct UserDTOMapper {

    private init() {}

    static func map(
        from user: IdentityApplication.UserDTO
    ) -> ProfileApplication.UserDTO {
        UserDTO(
            id: user.id,
            firstName: user.firstName,
            familyName: user.familyName,
            fullName: user.fullName,
            email: user.email
        )
    }

}
