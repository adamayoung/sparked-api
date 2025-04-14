//
//  InterestDefaultRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class InterestDefaultRepository: InterestRepository {

    private let interestService: any InterestService

    init(interestService: some InterestService) {
        self.interestService = interestService
    }

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest {
        let interest: Interest
        do {
            interest = try await interestService.fetch(byID: id)
        } catch InterestServiceError.notFound {
            throw .notFound
        } catch let error {
            throw .unknown(error)
        }

        return interest
    }

}
