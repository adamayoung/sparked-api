//
//  FetchGender.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchGender: FetchGenderUseCase {

    private let repository: any GenderRepository

    init(repository: some GenderRepository) {
        self.repository = repository
    }

    func execute(id: GenderDTO.ID) async throws(FetchGenderError) -> GenderDTO {
        let gender: Gender
        do {
            gender = try await repository.fetch(byID: id)
        } catch GenderRepositoryError.notFound {
            throw .notFound(genderID: id)
        } catch let error {
            throw .unknown(error)
        }

        let genderDTO = GenderDTOMapper.map(from: gender)

        return genderDTO
    }

}
