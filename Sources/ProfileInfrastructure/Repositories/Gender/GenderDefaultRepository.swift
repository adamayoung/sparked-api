//
//  GenderDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class GenderDefaultRepository: GenderRepository {

    private let genderService: any GenderService

    init(genderService: some GenderService) {
        self.genderService = genderService
    }

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender {
        let gender: Gender
        do {
            gender = try await genderService.fetch(byID: id)
        } catch GenderServiceError.notFound {
            throw .notFound
        } catch let error {
            throw .unknown(error)
        }

        return gender
    }

}
