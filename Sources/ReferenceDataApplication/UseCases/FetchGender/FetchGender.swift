//
//  FetchGender.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

final class FetchGender: FetchGenderUseCase {

    private let repository: any GenderRepository

    init(repository: some GenderRepository) {
        self.repository = repository
    }

    func execute(id: GenderDTO.ID) async throws(FetchGenderError) -> GenderDTO {
        let gender = try await repository.fetch(byID: id)
        let genderDTO = GenderDTOMapper.map(from: gender)

        return genderDTO
    }

}
