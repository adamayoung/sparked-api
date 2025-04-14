//
//  FetchExtendedInfoUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package protocol FetchExtendedInfoUseCase {

    func execute(
        id: ExtendedInfoDTO.ID,
        userContext: some UserContext
    ) async throws(FetchExtendedInfoError) -> ExtendedInfoDTO

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchExtendedInfoError) -> ExtendedInfoDTO

    func execute(
        profileID: ProfileDTO.ID,
        userContext: some UserContext
    ) async throws(FetchExtendedInfoError) -> ExtendedInfoDTO

}
