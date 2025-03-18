//
//  UserDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class UserDefaultRepository: UserRepository {

    private let userService: any UserService

    init(userService: some UserService) {
        self.userService = userService
    }

    func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User {
        let user: User
        do {
            user = try await userService.fetch(byID: id)
        } catch UserServiceError.notFound {
            throw .notFound
        } catch let error {
            throw .unknown(error)
        }

        return user
    }

}
