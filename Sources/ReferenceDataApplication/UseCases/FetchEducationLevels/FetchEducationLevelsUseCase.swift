//
//  FetchEducationLevelsUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package protocol FetchEducationLevelsUseCase: Sendable {

    func execute() async throws(FetchEducationLevelsError) -> [EducationLevelDTO]

}
