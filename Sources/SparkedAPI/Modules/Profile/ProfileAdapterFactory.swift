//
//  ProfileAdapterFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/02/2025.
//

import FileStorageKit
import Foundation
import IdentityApplication
import ProfileApplication
import ProfileInfrastructure
import ReferenceDataApplication

final class ProfileAdapterFactory {

    private init() {}

    static func makeCountryService(
        fetchCountryUseCase: some FetchCountryUseCase
    ) -> some CountryService {
        ProfileCountryServiceAdapter(fetchCountryUseCase: fetchCountryUseCase)
    }

    static func makeGenderService(
        fetchGenderUseCase: some FetchGenderUseCase
    ) -> some GenderService {
        ProfileGenderServiceAdapter(fetchGenderUseCase: fetchGenderUseCase)
    }

    static func makeInterestService(
        fetchInterestUseCase: some FetchInterestUseCase
    ) -> some InterestService {
        ProfileInterestServiceAdapter(fetchInterestUseCase: fetchInterestUseCase)
    }

    static func makeUserService(fetchUserUseCase: some FetchUserUseCase) -> some UserService {
        ProfileUserServiceAdapter(fetchUserUseCase: fetchUserUseCase)
    }

    static func makeProfileFileStorageService(
        fileStorage: some FileStorage,
        containerName: String
    ) -> some FileStorageService {
        ProfileFileStorageServiceAdapter(
            fileStorage: fileStorage,
            containerName: containerName
        )
    }

}
