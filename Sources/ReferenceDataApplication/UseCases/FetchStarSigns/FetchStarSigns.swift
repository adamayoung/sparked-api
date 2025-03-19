//
//  FetchStarSigns.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchStarSigns: FetchStarSignsUseCase {

    private let repository: any StarSignRepository

    init(repository: some StarSignRepository) {
        self.repository = repository
    }

    func execute() async throws(FetchStarSignsError) -> [StarSignDTO] {
        let starSigns: [StarSign]
        do {
            starSigns = try await repository.fetchAll()
        } catch let error {
            throw .unknown(error)
        }

        let starSignDTOs =
            starSigns
            .sorted { $0.index < $1.index }
            .map(StarSignDTOMapper.map)

        return starSignDTOs
    }

}
