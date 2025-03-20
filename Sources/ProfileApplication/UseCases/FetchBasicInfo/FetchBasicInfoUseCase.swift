//
//  FetchBasicInfoUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol FetchBasicInfoUseCase {

    func execute(
        id: BasicInfoDTO.ID,
        userContext: some UserContext
    ) async throws(FetchBasicInfoError) -> BasicInfoDTO

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicInfoError) -> BasicInfoDTO

    func execute(
        profileID: ProfileDTO.ID,
        userContext: some UserContext
    ) async throws(FetchBasicInfoError) -> BasicInfoDTO

}
