//
//  StarSignDefaultRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class StarSignDefaultRepository: StarSignRepository {

    private let starSignService: any StarSignService

    init(starSignService: some StarSignService) {
        self.starSignService = starSignService
    }

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign {
        let starSign: StarSign
        do {
            starSign = try await starSignService.fetch(byID: id)
        } catch StarSignServiceError.notFound {
            throw .notFound
        } catch let error {
            throw .unknown(error)
        }

        return starSign
    }

}
