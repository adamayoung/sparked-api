//
//  FetchInterestUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package protocol FetchInterestUseCase: Sendable {

    func execute(id: InterestDTO.ID) async throws(FetchInterestError) -> InterestDTO

}
