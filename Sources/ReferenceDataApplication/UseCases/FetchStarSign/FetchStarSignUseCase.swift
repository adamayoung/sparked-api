//
//  FetchStarSignUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package protocol FetchStarSignUseCase: Sendable {

    func execute(id: StarSignDTO.ID) async throws(FetchStarSignError) -> StarSignDTO

}
