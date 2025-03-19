//
//  FetchStarSign.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchStarSign: FetchStarSignUseCase {

    private let repository: any StarSignRepository

    init(repository: some StarSignRepository) {
        self.repository = repository
    }

    func execute(id: StarSignDTO.ID) async throws(FetchStarSignError) -> StarSignDTO {
        let starSign: StarSign
        do {
            starSign = try await repository.fetch(byID: id)
        } catch StarSignRepositoryError.notFound {
            throw .notFound(starSignID: id)
        } catch let error {
            throw .unknown(error)
        }

        let starSignDTO = StarSignDTOMapper.map(from: starSign)

        return starSignDTO
    }

}
