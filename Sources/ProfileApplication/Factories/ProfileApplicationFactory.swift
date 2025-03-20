//
//  ProfileFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation

package final class ProfileApplicationFactory {

    private init() {}

    package static func makeFetchProfileUseCase(
        basicProfileRepository: some BasicProfileRepository,
        basicInfoRepository: some BasicInfoRepository,
        profilePhotoRepository: some ProfilePhotoRepository,
        imageRepository: some ImageRepository,
        profileInterestRepository: some ProfileInterestRepository,
        interestRepository: some InterestRepository
    ) -> some FetchProfileUseCase {
        FetchProfile(
            basicProfileRepository: basicProfileRepository,
            basicInfoRepository: basicInfoRepository,
            profilePhotoRepository: profilePhotoRepository,
            imageRepository: imageRepository,
            profileInterestRepository: profileInterestRepository,
            interestRepository: interestRepository
        )
    }

    package static func makeCreateBasicProfileUseCase(
        repository: some BasicProfileRepository,
        userRepository: some UserRepository
    ) -> some CreateBasicProfileUseCase {
        CreateBasicProfile(
            repository: repository,
            userRepository: userRepository
        )
    }

    package static func makeFetchBasicProfileUseCase(
        repository: some BasicProfileRepository
    ) -> some FetchBasicProfileUseCase {
        FetchBasicProfile(repository: repository)
    }

    package static func makeCreateBasicInfoUseCase(
        repository: some BasicInfoRepository,
        basicProfileRepository: some BasicProfileRepository,
        countryRepository: some CountryRepository,
        genderRepository: some GenderRepository
    ) -> some CreateBasicInfoUseCase {
        CreateBasicInfo(
            repository: repository,
            basicProfileRepository: basicProfileRepository,
            countryRepository: countryRepository,
            genderRepository: genderRepository
        )
    }

    package static func makeFetchBasicInfoUseCase(
        repository: some BasicInfoRepository
    ) -> some FetchBasicInfoUseCase {
        FetchBasicInfo(repository: repository)
    }

    package static func makeAddProfilePhotoUseCase(
        repository: some ProfilePhotoRepository,
        basicProfileRepository: some BasicProfileRepository,
        imageRepository: some ImageRepository
    ) -> some AddProfilePhotoUseCase {
        AddProfilePhoto(
            repository: repository,
            basicProfileRepository: basicProfileRepository,
            imageRepository: imageRepository
        )
    }

    package static func makeFetchProfilePhotosUseCase(
        repository: some ProfilePhotoRepository,
        basicProfileRepository: some BasicProfileRepository,
        imageRepository: some ImageRepository
    ) -> some FetchProfilePhotosUseCase {
        FetchProfilePhotos(
            repository: repository,
            basicProfileRepository: basicProfileRepository,
            imageRepository: imageRepository
        )
    }

    package static func makeFetchProfilePhotoUseCase(
        repository: some ProfilePhotoRepository,
        imageRepository: some ImageRepository
    ) -> some FetchProfilePhotoUseCase {
        FetchProfilePhoto(
            repository: repository,
            imageRepository: imageRepository
        )
    }

    package static func makeChangeProfilePhotoOrderUseCase(
        repository: some ProfilePhotoRepository,
        basicProfileRepository: some BasicProfileRepository,
        imageRepository: some ImageRepository
    ) -> some ChangeProfilePhotoOrderUseCase {
        ChangeProfilePhotoOrder(
            repository: repository,
            basicProfileRepository: basicProfileRepository,
            imageRepository: imageRepository
        )
    }

    package static func makeDeleteProfilePhotoUseCase(
        repository: some ProfilePhotoRepository,
        basicProfileRepository: some BasicProfileRepository,
        imageRepository: some ImageRepository
    ) -> some DeleteProfilePhotoUseCase {
        DeleteProfilePhoto(
            repository: repository,
            basicProfileRepository: basicProfileRepository,
            imageRepository: imageRepository
        )
    }

    package static func makeAddProfileInterestUseCase(
        repository: some ProfileInterestRepository,
        interestRepository: some InterestRepository,
        basicProfileRepository: some BasicProfileRepository
    ) -> some AddProfileInterestUseCase {
        AddProfileInterest(
            repository: repository,
            interestRepository: interestRepository,
            basicProfileRepository: basicProfileRepository
        )
    }

    package static func makeFetchProfileInterestsUseCase(
        repository: some ProfileInterestRepository,
        interestRepository: some InterestRepository,
        basicProfileRepository: some BasicProfileRepository
    ) -> some FetchProfileInterestsUseCase {
        FetchProfileInterests(
            repository: repository,
            interestRepository: interestRepository,
            basicProfileRepository: basicProfileRepository
        )
    }

    package static func makeRemoveProfileInterestUseCase(
        repository: some ProfileInterestRepository,
        basicProfileRepository: some BasicProfileRepository
    ) -> some RemoveProfileInterestUseCase {
        RemoveProfileInterest(
            repository: repository,
            basicProfileRepository: basicProfileRepository
        )
    }

}
