//
//  GenderAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileApplication
import ReferenceDataApplication

final class ProfileGenderAdapter: GenderService {

    private let fetchGendersUseCase: any FetchGendersUseCase

    init(fetchGendersUseCase: some FetchGendersUseCase) {
        self.fetchGendersUseCase = fetchGendersUseCase
    }

    func genders() async throws(GenderServiceError) -> [ProfileApplication.GenderDTO] {
        let genderReferences: [ReferenceDataApplication.GenderDTO]
        do {
            genderReferences = try await fetchGendersUseCase.execute()
        } catch let error {
            throw .unknown(error)
        }

        let genderDTOs = genderReferences.map(GenderDTOMapper.map)

        return genderDTOs
    }

}

private struct GenderDTOMapper {

    private init() {}

    static func map(
        from gender: ReferenceDataApplication.GenderDTO
    ) -> ProfileApplication.GenderDTO {
        GenderDTO(
            id: gender.id,
            name: gender.name
        )
    }

}
