//
//  ProfileFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation

package final class ProfileApplicationFactory {

    private init() {}

    package static func makeFetchProfileUseCase(
        basicProfileRepository: some BasicProfileRepository,
        basicInfoRepository: some BasicInfoRepository
    ) -> some FetchProfileUseCase {
        FetchProfile(
            basicProfileRepository: basicProfileRepository,
            basicInfoRepository: basicInfoRepository
        )
    }

    package static func makeCreateBasicProfileUseCase(
        repository: some BasicProfileRepository,
        userService: some UserService
    ) -> some CreateBasicProfileUseCase {
        CreateBasicProfile(repository: repository, userService: userService)
    }

    package static func makeFetchBasicProfileUseCase(
        repository: some BasicProfileRepository
    ) -> some FetchBasicProfileUseCase {
        FetchBasicProfile(repository: repository)
    }

    package static func makeCreateBasicInfoUseCase(
        repository: some BasicInfoRepository,
        userService: some UserService,
        countryService: some CountryService,
        genderService: some GenderService
    ) -> some CreateBasicInfoUseCase {
        CreateBasicInfo(
            repository: repository,
            userService: userService,
            countryService: countryService,
            genderService: genderService
        )
    }

    package static func makeFetchBasicInfoUseCase(
        repository: some BasicInfoRepository
    ) -> some FetchBasicInfoUseCase {
        FetchBasicInfo(repository: repository)
    }

}
