//
//  FetchBasicInfoUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol FetchBasicInfoUseCase {

    func execute(profileID: UUID) async throws(FetchBasicInfoError) -> BasicInfo

}
