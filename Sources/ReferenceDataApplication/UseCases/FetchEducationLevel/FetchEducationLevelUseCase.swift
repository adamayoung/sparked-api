//
//  FetchEducationLevelUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package protocol FetchEducationLevelUseCase: Sendable {

    func execute(
        id: EducationLevelDTO.ID
    ) async throws(FetchEducationLevelError) -> EducationLevelDTO

}
