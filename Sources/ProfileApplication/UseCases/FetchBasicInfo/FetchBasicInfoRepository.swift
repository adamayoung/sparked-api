//
//  FetchBasicInfoRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileDomain

package protocol FetchBasicInfoRepository {

    func fetch(byProfileID profileID: UUID) async throws(FetchBasicInfoError) -> BasicInfo

}
