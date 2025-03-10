//
//  ProfileCountryServiceAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileApplication
import ReferenceDataApplication

final class ProfileCountryServiceAdapter: CountryService {

    private let fetchCountryUseCase: any FetchCountryUseCase

    init(fetchCountryUseCase: some FetchCountryUseCase) {
        self.fetchCountryUseCase = fetchCountryUseCase
    }

    func doesCountryExist(withID id: UUID) async throws(CountryServiceError) -> Bool {
        do {
            _ = try await fetchCountryUseCase.execute(id: id)
        } catch FetchCountryError.notFound {
            return false
        } catch let error {
            throw .unknown(error)
        }

        return true
    }

}
