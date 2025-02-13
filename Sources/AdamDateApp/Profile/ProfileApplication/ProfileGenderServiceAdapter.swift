//
//  ProfileGenderServiceAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileApplication
import ReferenceDataApplication

final class ProfileGenderServiceAdapter: GenderService {

    private let fetchGenderUseCase: @Sendable () -> any FetchGenderUseCase

    init(fetchGenderUseCase: @escaping @Sendable () -> any FetchGenderUseCase) {
        self.fetchGenderUseCase = fetchGenderUseCase
    }

    func doesGenderExist(withID id: UUID) async throws(GenderServiceError) -> Bool {
        do {
            _ = try await fetchGenderUseCase().execute(id: id)
        } catch FetchGenderError.notFound {
            return false
        } catch let error {
            throw .unknown(error)
        }

        return true
    }

}
