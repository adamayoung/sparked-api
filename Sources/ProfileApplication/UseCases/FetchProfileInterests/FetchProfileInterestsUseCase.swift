//
//  FetchProfileInterestsUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package protocol FetchProfileInterestsUseCase {

    func execute(profileID: UUID) async throws(FetchProfileInterestsError) -> [ProfileInterestDTO]

}
