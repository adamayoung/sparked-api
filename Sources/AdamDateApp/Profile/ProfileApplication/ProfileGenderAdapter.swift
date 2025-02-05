//
//  GenderAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain
import ReferenceDataDomain

final class ProfileGenderAdapter: GenderProvider {

    private let fetchGendersUseCase: any FetchGendersUseCase

    init(fetchGendersUseCase: some FetchGendersUseCase) {
        self.fetchGendersUseCase = fetchGendersUseCase
    }

    func genders() async throws(GenderProviderError) -> [ProfileDomain.Gender] {
        let genderReferences: [ReferenceDataDomain.Gender]
        do {
            genderReferences = try await fetchGendersUseCase.execute()
        } catch let error {
            throw .unknown(error)
        }

        let genders = genderReferences.map(GenderMapper.map)
        return genders
    }

}

private struct GenderMapper {

    private init() {}

    static func map(from gender: ReferenceDataDomain.Gender) -> ProfileDomain.Gender {
        ProfileDomain.Gender(
            id: gender.id,
            name: gender.name
        )
    }

}
