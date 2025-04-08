//
//  Request+UseCases.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileApplication
import Vapor

extension Application {

    package struct ProfileWebAPIUseCases {
        package struct Provider {
            let run: (Application) -> Void

            package init(_ run: @escaping (Application) -> Void) {
                self.run = run
            }
        }

        final class Storage: @unchecked Sendable {

            var makeCreateBasicProfileUseCase: ((Application) -> any CreateBasicProfileUseCase)?
            var makeFetchBasicProfileUseCase: ((Application) -> any FetchBasicProfileUseCase)?

            var makeCreateBasicInfoUseCase: ((Application) -> any CreateBasicInfoUseCase)?
            var makeFetchBasicInfoUseCase: ((Application) -> any FetchBasicInfoUseCase)?

            var makeCreateExtendedInfoUseCase: ((Application) -> any CreateExtendedInfoUseCase)?
            var makeFetchExtendedInfoUseCase: ((Application) -> any FetchExtendedInfoUseCase)?

            var makeFetchProfileUseCase: ((Application) -> any FetchProfileUseCase)?

            var makeAddProfilePhotoUseCase: ((Application) -> any AddProfilePhotoUseCase)?
            var makeFetchProfilePhotosUseCase: ((Application) -> any FetchProfilePhotosUseCase)?
            var makeFetchProfilePhotoUseCase: ((Application) -> any FetchProfilePhotoUseCase)?
            var makeChangeProfilePhotoOrderUseCase:
                (
                    (Application) -> any ChangeProfilePhotoOrderUseCase
                )?
            var makeDeleteProfilePhotoUseCase: ((Application) -> any DeleteProfilePhotoUseCase)?

            var makeFetchProfileInterestsUseCase:
                ((Application) -> any FetchProfileInterestsUseCase)?
            var makeAddProfileInterestUseCase: ((Application) -> any AddProfileInterestUseCase)?
            var makeRemoveProfileInterestUseCase:
                ((Application) -> any RemoveProfileInterestUseCase)?

            init() {}

        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var createBasicProfileUseCase: any CreateBasicProfileUseCase {
            guard let makeUseCase = self.storage.makeCreateBasicProfileUseCase else {
                fatalError(
                    "No CreateBasicProfileUserCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchBasicProfileUseCase: any FetchBasicProfileUseCase {
            guard let makeUseCase = self.storage.makeFetchBasicProfileUseCase else {
                fatalError(
                    "No FetchBasicProfileUserCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var createBasicInfoUseCase: any CreateBasicInfoUseCase {
            guard let makeUseCase = self.storage.makeCreateBasicInfoUseCase else {
                fatalError(
                    "No CreateBasicInfoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchBasicInfoUseCase: any FetchBasicInfoUseCase {
            guard let makeUseCase = self.storage.makeFetchBasicInfoUseCase else {
                fatalError(
                    "No FetchBasicInfoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var createExtendedInfoUseCase: any CreateExtendedInfoUseCase {
            guard let makeUseCase = self.storage.makeCreateExtendedInfoUseCase else {
                fatalError(
                    "No CreateExtendedInfoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchExtendedInfoUseCase: any FetchExtendedInfoUseCase {
            guard let makeUseCase = self.storage.makeFetchExtendedInfoUseCase else {
                fatalError(
                    "No FetchExtendedInfoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchProfileUseCase: any FetchProfileUseCase {
            guard let makeUseCase = self.storage.makeFetchProfileUseCase else {
                fatalError(
                    "No FetchProfileUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var addProfilePhotoUseCase: any AddProfilePhotoUseCase {
            guard let makeUseCase = self.storage.makeAddProfilePhotoUseCase else {
                fatalError(
                    "No AddProfilePhotoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchProfilePhotosUseCase: any FetchProfilePhotosUseCase {
            guard let makeUseCase = self.storage.makeFetchProfilePhotosUseCase else {
                fatalError(
                    "No FetchProfilePhotosUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchProfilePhotoUseCase: any FetchProfilePhotoUseCase {
            guard let makeUseCase = self.storage.makeFetchProfilePhotoUseCase else {
                fatalError(
                    "No FetchProfilePhotoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var changeProfilePhotoOrderUseCase: any ChangeProfilePhotoOrderUseCase {
            guard let makeUseCase = self.storage.makeChangeProfilePhotoOrderUseCase else {
                fatalError(
                    "No ChangeProfilePhotoOrderUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var deleteProfilePhotoUseCase: any DeleteProfilePhotoUseCase {
            guard let makeUseCase = self.storage.makeDeleteProfilePhotoUseCase else {
                fatalError(
                    "No DeleteProfilePhotoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var addProfileInterestUseCase: any AddProfileInterestUseCase {
            guard let makeUseCase = self.storage.makeAddProfileInterestUseCase else {
                fatalError(
                    "No AddProfileInterestUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchProfileInterestsUseCase: any FetchProfileInterestsUseCase {
            guard let makeUseCase = self.storage.makeFetchProfileInterestsUseCase else {
                fatalError(
                    "No FetchProfileInterestsUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var removeProfileInterestUseCase: any RemoveProfileInterestUseCase {
            guard let makeUseCase = self.storage.makeRemoveProfileInterestUseCase else {
                fatalError(
                    "No RemoveProfileInterestUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeUseCase: @escaping (Application) -> any CreateBasicProfileUseCase) {
            self.storage.makeCreateBasicProfileUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchBasicProfileUseCase) {
            self.storage.makeFetchBasicProfileUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any CreateBasicInfoUseCase) {
            self.storage.makeCreateBasicInfoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchBasicInfoUseCase) {
            self.storage.makeFetchBasicInfoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any CreateExtendedInfoUseCase) {
            self.storage.makeCreateExtendedInfoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchExtendedInfoUseCase) {
            self.storage.makeFetchExtendedInfoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchProfileUseCase) {
            self.storage.makeFetchProfileUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any AddProfilePhotoUseCase) {
            self.storage.makeAddProfilePhotoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchProfilePhotosUseCase) {
            self.storage.makeFetchProfilePhotosUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchProfilePhotoUseCase) {
            self.storage.makeFetchProfilePhotoUseCase = makeUseCase
        }

        package func use(
            _ makeUseCase: @escaping (Application) -> any ChangeProfilePhotoOrderUseCase
        ) {
            self.storage.makeChangeProfilePhotoOrderUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any DeleteProfilePhotoUseCase) {
            self.storage.makeDeleteProfilePhotoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any AddProfileInterestUseCase) {
            self.storage.makeAddProfileInterestUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any FetchProfileInterestsUseCase)
        {
            self.storage.makeFetchProfileInterestsUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> any RemoveProfileInterestUseCase)
        {
            self.storage.makeRemoveProfileInterestUseCase = makeUseCase
        }

        func initialize() {
            self.application.storage[Key.self] = .init()
        }

        private var storage: Storage {
            if self.application.storage[Key.self] == nil {
                self.initialize()
            }

            guard let storage = application.storage[Key.self] else {
                fatalError("Unable to retrieve ProfileUseCases storage")
            }

            return storage
        }
    }

    package var profileWebAPIUseCases: ProfileWebAPIUseCases {
        .init(application: self)
    }

}

extension Request {

    var createBasicProfileUseCase: any CreateBasicProfileUseCase {
        application.profileWebAPIUseCases.createBasicProfileUseCase
    }

    var fetchBasicProfileUseCase: any FetchBasicProfileUseCase {
        application.profileWebAPIUseCases.fetchBasicProfileUseCase
    }

    var createBasicInfoUseCase: any CreateBasicInfoUseCase {
        application.profileWebAPIUseCases.createBasicInfoUseCase
    }

    var fetchBasicInfoUseCase: any FetchBasicInfoUseCase {
        application.profileWebAPIUseCases.fetchBasicInfoUseCase
    }

    var createExtendedInfoUseCase: any CreateExtendedInfoUseCase {
        application.profileWebAPIUseCases.createExtendedInfoUseCase
    }

    var fetchExtendedInfoUseCase: any FetchExtendedInfoUseCase {
        application.profileWebAPIUseCases.fetchExtendedInfoUseCase
    }

    var fetchProfileUseCase: any FetchProfileUseCase {
        application.profileWebAPIUseCases.fetchProfileUseCase
    }

    var addProfilePhotoUseCase: any AddProfilePhotoUseCase {
        application.profileWebAPIUseCases.addProfilePhotoUseCase
    }

    var fetchProfilePhotosUseCase: any FetchProfilePhotosUseCase {
        application.profileWebAPIUseCases.fetchProfilePhotosUseCase
    }

    var fetchProfilePhotoUseCase: any FetchProfilePhotoUseCase {
        application.profileWebAPIUseCases.fetchProfilePhotoUseCase
    }

    var changeProfilePhotoOrderUseCase: any ChangeProfilePhotoOrderUseCase {
        application.profileWebAPIUseCases.changeProfilePhotoOrderUseCase
    }

    var deleteProfilePhotoUseCase: any DeleteProfilePhotoUseCase {
        application.profileWebAPIUseCases.deleteProfilePhotoUseCase
    }

    var addProfileInterestUseCase: any AddProfileInterestUseCase {
        application.profileWebAPIUseCases.addProfileInterestUseCase
    }

    var fetchProfileInterestsUseCase: any FetchProfileInterestsUseCase {
        application.profileWebAPIUseCases.fetchProfileInterestsUseCase
    }

    var removeProfileInterestUseCase: any RemoveProfileInterestUseCase {
        application.profileWebAPIUseCases.removeProfileInterestUseCase
    }

}
