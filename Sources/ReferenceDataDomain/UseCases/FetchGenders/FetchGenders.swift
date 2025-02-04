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

    package func execute() async throws(FetchGendersError) -> [Gender] {
        let genders = try await repository.genders()
        return genders
    }

}
