//
//  FetchProfileUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation

package protocol FetchProfileUseCase {

    func execute(id: UUID) async throws(FetchProfileError) -> ProfileDTO

    func execute(userID: UUID) async throws(FetchProfileError) -> ProfileDTO

}
