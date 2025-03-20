//
//  FetchStarSignsUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package protocol FetchStarSignsUseCase: Sendable {

    func execute() async throws(FetchStarSignsError) -> [StarSignDTO]

}
