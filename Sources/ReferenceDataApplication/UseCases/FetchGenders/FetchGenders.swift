//
//  FetchGenders.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package final class FetchGenders: FetchGendersUseCase {

    private let repository: any FetchGendersRepository

    package init(repository: some FetchGendersRepository) {
        self.repository = repository
    }

    package func execute() async throws(FetchGendersError) -> [GenderDTO] {
        let genders = try await repository.genders()
        let genderDTOS = genders.map(GenderDTOMapper.map)
            .sorted { $0.name.localizedCompare($1.name) == .orderedAscending }

        return genderDTOS
    }

}
