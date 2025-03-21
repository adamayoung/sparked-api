//
//  FetchInterestsUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation

package protocol FetchInterestsUseCase: Sendable {

    func execute(
        interestGroupID: InterestGroupDTO.ID
    ) async throws(FetchInterestsError) -> [InterestDTO]

}
