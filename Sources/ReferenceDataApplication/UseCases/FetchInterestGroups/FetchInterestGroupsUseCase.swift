//
//  FetchInterestGroupsUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package protocol FetchInterestGroupsUseCase: Sendable {

    func execute() async throws(FetchInterestGroupsError) -> [InterestGroupDTO]

    func executeIncludingInterests() async throws(FetchInterestGroupsError)
        -> [InterestGroupAggregateDTO]

}
