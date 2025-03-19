//
//  ReferenceDataApplicationFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package final class ReferenceDataApplicationFactory {

    private init() {}

    package static func makeFetchCountriesUseCase(
        countryRepository: some CountryRepository
    ) -> some FetchCountriesUseCase {
        FetchCountries(repository: countryRepository)
    }

    package static func makeFetchCountryUseCase(
        countryRepository: some CountryRepository
    ) -> some FetchCountryUseCase {
        FetchCountry(repository: countryRepository)
    }

    package static func makeFetchGendersUseCase(
        genderRepository: some GenderRepository
    ) -> some FetchGendersUseCase {
        FetchGenders(repository: genderRepository)
    }

    package static func makeFetchGenderUseCase(
        genderRepository: some GenderRepository
    ) -> some FetchGenderUseCase {
        FetchGender(repository: genderRepository)
    }

    package static func makeFetchInterestGroupsUseCase(
        interestGroupRepository: some InterestGroupRepository,
        interestRepository: some InterestRepository
    ) -> some FetchInterestGroupsUseCase {
        FetchInterestGroups(
            repository: interestGroupRepository,
            interestRepository: interestRepository
        )
    }

    package static func makeFetchInterestGroupUseCase(
        interestGroupRepository: some InterestGroupRepository,
        interestRepository: some InterestRepository
    ) -> some FetchInterestGroupUseCase {
        FetchInterestGroup(
            repository: interestGroupRepository,
            interestRepository: interestRepository
        )
    }

    package static func makeFetchInterestsUseCase(
        interestRepository: some InterestRepository
    ) -> some FetchInterestsUseCase {
        FetchInterests(repository: interestRepository)
    }

    package static func makeFetchInterestUseCase(
        interestRepository: some InterestRepository
    ) -> some FetchInterestUseCase {
        FetchInterest(repository: interestRepository)
    }

    package static func makeFetchStarSignsUseCase(
        starSignRepository: some StarSignRepository
    ) -> some FetchStarSignsUseCase {
        FetchStarSigns(repository: starSignRepository)
    }

    package static func makeFetchStarSignUseCase(
        starSignRepository: some StarSignRepository
    ) -> some FetchStarSignUseCase {
        FetchStarSign(repository: starSignRepository)
    }

    package static func makeFetchEducationLevelsUseCase(
        educationLevelRepository: some EducationLevelRepository
    ) -> some FetchEducationLevelsUseCase {
        FetchEducationLevels(repository: educationLevelRepository)
    }

    package static func makeFetchEducationLevelUseCase(
        educationLevelRepository: some EducationLevelRepository
    ) -> some FetchEducationLevelUseCase {
        FetchEducationLevel(repository: educationLevelRepository)
    }

}
