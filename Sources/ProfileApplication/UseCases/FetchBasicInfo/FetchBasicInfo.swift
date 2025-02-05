//
//  FetchBasicInfo.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package final class FetchBasicInfo: FetchBasicInfoUseCase {

    private let repository: any FetchBasicInfoRepository

    package init(repository: any FetchBasicInfoRepository) {
        self.repository = repository
    }

    package func execute(profileID: UUID) async throws(FetchBasicInfoError) -> BasicInfoDTO {
        let basicInfo = try await repository.fetch(byProfileID: profileID)
        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

}
