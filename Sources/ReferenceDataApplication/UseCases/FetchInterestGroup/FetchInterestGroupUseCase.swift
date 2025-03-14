//
//  FetchInterestGroupUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package protocol FetchInterestGroupUseCase: Sendable {

    func execute(id: InterestGroupDTO.ID) async throws(FetchInterestGroupError) -> InterestGroupDTO

    func executeIncludingInterests(id: InterestGroupDTO.ID) async throws(FetchInterestGroupError)
        -> InterestGroupAggregateDTO

}
