//
//  FetchGenders.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

final class FetchGenders: FetchGendersUseCase {

    private let repository: any GenderRepository

    init(repository: some GenderRepository) {
        self.repository = repository
    }

    func execute() async throws(FetchGendersError) -> [GenderDTO] {
        let genders = try await repository.fetchAll()
        let genderDTOS = genders.map(GenderDTOMapper.map)
            .sorted { $0.name.localizedCompare($1.name) == .orderedAscending }

        return genderDTOS
    }

}
