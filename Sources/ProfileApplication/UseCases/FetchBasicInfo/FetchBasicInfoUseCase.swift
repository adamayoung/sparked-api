//
//  FetchBasicInfoUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol FetchBasicInfoUseCase {

    func execute(id: BasicInfoDTO.ID) async throws(FetchBasicInfoError) -> BasicInfoDTO

    func execute(userID: UUID) async throws(FetchBasicInfoError) -> BasicInfoDTO

    func execute(profileID: ProfileDTO.ID) async throws(FetchBasicInfoError) -> BasicInfoDTO

}
