//
//  ProfilePresentationFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import ProfileApplication
import Vapor

package final class ProfilePresentationFactory: Sendable {

    private init() {}

    package static func makeProfileController(
        fetchProfileUseCase: @escaping @Sendable () -> any FetchProfileUseCase
    ) -> some RouteCollection {
        let dependencies = ProfileController.Dependencies(
            fetchProfileUseCase: fetchProfileUseCase
        )

        return ProfileController(dependencies: dependencies)
    }

    package static func makeBasicProfileController(
        createBasicProfileUserCase: @escaping @Sendable () -> any CreateBasicProfileUseCase,
        fetchBasicProfileUseCase: @escaping @Sendable () -> any FetchBasicProfileUseCase
    ) -> some RouteCollection {
        let dependencies = BasicProfileController.Dependencies(
            createBasicProfileUseCase: createBasicProfileUserCase,
            fetchBasicProfileUseCase: fetchBasicProfileUseCase
        )

        return BasicProfileController(dependencies: dependencies)
    }

    package static func makeBasicInfoController(
        createBasicInfoUseCase: @escaping @Sendable () -> any CreateBasicInfoUseCase,
        fetchBasicInfoUseCase: @escaping @Sendable () -> any FetchBasicInfoUseCase,
        fetchBasicProfileUseCase: @escaping @Sendable () -> any FetchBasicProfileUseCase
    ) -> some RouteCollection {
        let dependencies = BasicInfoController.Dependencies(
            createBasicInfoUseCase: createBasicInfoUseCase,
            fetchBasicInfoUseCase: fetchBasicInfoUseCase,
            fetchBasicProfileUseCase: fetchBasicProfileUseCase
        )

        return BasicInfoController(dependencies: dependencies)
    }

}
