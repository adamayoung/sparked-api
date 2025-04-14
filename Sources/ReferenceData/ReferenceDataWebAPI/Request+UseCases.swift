//
//  Request+UseCases.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/04/2025.
//

import ReferenceDataApplication
import Vapor

extension Request {

    var fetchCountriesUseCase: any FetchCountriesUseCase {
        application.referenceDataWebAPIUseCases.fetchCountriesUseCase
    }

    var fetchCountryUseCase: any FetchCountryUseCase {
        application.referenceDataWebAPIUseCases.fetchCountryUseCase
    }

    var fetchGendersUseCase: any FetchGendersUseCase {
        application.referenceDataWebAPIUseCases.fetchGendersUseCase
    }

    var fetchGenderUseCase: any FetchGenderUseCase {
        application.referenceDataWebAPIUseCases.fetchGenderUseCase
    }

    var fetchInterestGroupsUseCase: any FetchInterestGroupsUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestGroupsUseCase
    }

    var fetchInterestGroupUseCase: any FetchInterestGroupUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestGroupUseCase
    }

    var fetchInterestsUseCase: any FetchInterestsUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestsUseCase
    }

    var fetchInterestUseCase: any FetchInterestUseCase {
        application.referenceDataWebAPIUseCases.fetchInterestUseCase
    }

    var fetchStarSignsUseCase: any FetchStarSignsUseCase {
        application.referenceDataWebAPIUseCases.fetchStarSignsUseCase
    }

    var fetchStarSignUseCase: any FetchStarSignUseCase {
        application.referenceDataWebAPIUseCases.fetchStarSignUseCase
    }

    var fetchEducationLevelsUseCase: any FetchEducationLevelsUseCase {
        application.referenceDataWebAPIUseCases.fetchEducationLevelsUseCase
    }

    var fetchEducationLevelUseCase: any FetchEducationLevelUseCase {
        application.referenceDataWebAPIUseCases.fetchEducationLevelUseCase
    }

}
