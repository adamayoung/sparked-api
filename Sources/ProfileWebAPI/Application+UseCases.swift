//
//  Request+UseCases.swift
//  AdamDateApp
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

            var makeCreateBasicProfileUseCase: ((Application) -> CreateBasicProfileUseCase)?
            var makeFetchBasicProfileUseCase: ((Application) -> FetchBasicProfileUseCase)?

            var makeCreateBasicInfoUseCase: ((Application) -> CreateBasicInfoUseCase)?
            var makeFetchBasicInfoUseCase: ((Application) -> FetchBasicInfoUseCase)?

            var makeFetchProfileUseCase: ((Application) -> FetchProfileUseCase)?

            var makeAddProfilePhotoUseCase: ((Application) -> AddProfilePhotoUseCase)?
            var makeFetchProfilePhotosUseCase: ((Application) -> FetchProfilePhotosUseCase)?
            var makeFetchProfilePhotoUseCase: ((Application) -> FetchProfilePhotoUseCase)?
            var makeChangeProfilePhotoOrderUseCase:
                (
                    (Application) -> ChangeProfilePhotoOrderUseCase
                )?
            var makeDeleteProfilePhotoUseCase: ((Application) -> DeleteProfilePhotoUseCase)?

            init() {}

        }

        struct Key: StorageKey, Sendable {
            typealias Value = Storage
        }

        let application: Application

        var createBasicProfileUseCase: CreateBasicProfileUseCase {
            guard let makeUseCase = self.storage.makeCreateBasicProfileUseCase else {
                fatalError(
                    "No CreateBasicProfileUserCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchBasicProfileUseCase: FetchBasicProfileUseCase {
            guard let makeUseCase = self.storage.makeFetchBasicProfileUseCase else {
                fatalError(
                    "No FetchBasicProfileUserCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var createBasicInfoUseCase: CreateBasicInfoUseCase {
            guard let makeUseCase = self.storage.makeCreateBasicInfoUseCase else {
                fatalError(
                    "No CreateBasicInfoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchBasicInfoUseCase: FetchBasicInfoUseCase {
            guard let makeUseCase = self.storage.makeFetchBasicInfoUseCase else {
                fatalError(
                    "No FetchBasicInfoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchProfileUseCase: FetchProfileUseCase {
            guard let makeUseCase = self.storage.makeFetchProfileUseCase else {
                fatalError(
                    "No FetchProfileUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var addProfilePhotoUseCase: AddProfilePhotoUseCase {
            guard let makeUseCase = self.storage.makeAddProfilePhotoUseCase else {
                fatalError(
                    "No AddProfilePhotoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchProfilePhotosUseCase: FetchProfilePhotosUseCase {
            guard let makeUseCase = self.storage.makeFetchProfilePhotosUseCase else {
                fatalError(
                    "No FetchProfilePhotosUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var fetchProfilePhotoUseCase: FetchProfilePhotoUseCase {
            guard let makeUseCase = self.storage.makeFetchProfilePhotoUseCase else {
                fatalError(
                    "No FetchProfilePhotoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var changeProfilePhotoOrderUseCase: ChangeProfilePhotoOrderUseCase {
            guard let makeUseCase = self.storage.makeChangeProfilePhotoOrderUseCase else {
                fatalError(
                    "No ChangeProfilePhotoOrderUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        var deleteProfilePhotoUseCase: DeleteProfilePhotoUseCase {
            guard let makeUseCase = self.storage.makeDeleteProfilePhotoUseCase else {
                fatalError(
                    "No DeleteProfilePhotoUseCase configured. Configure with app.profileWebAPIUseCases.use(...)"
                )
            }
            return makeUseCase(self.application)
        }

        package func use(_ provider: Provider) {
            provider.run(self.application)
        }

        package func use(_ makeUseCase: @escaping (Application) -> CreateBasicProfileUseCase) {
            self.storage.makeCreateBasicProfileUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchBasicProfileUseCase) {
            self.storage.makeFetchBasicProfileUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> CreateBasicInfoUseCase) {
            self.storage.makeCreateBasicInfoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchBasicInfoUseCase) {
            self.storage.makeFetchBasicInfoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchProfileUseCase) {
            self.storage.makeFetchProfileUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> AddProfilePhotoUseCase) {
            self.storage.makeAddProfilePhotoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchProfilePhotosUseCase) {
            self.storage.makeFetchProfilePhotosUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> FetchProfilePhotoUseCase) {
            self.storage.makeFetchProfilePhotoUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> ChangeProfilePhotoOrderUseCase) {
            self.storage.makeChangeProfilePhotoOrderUseCase = makeUseCase
        }

        package func use(_ makeUseCase: @escaping (Application) -> DeleteProfilePhotoUseCase) {
            self.storage.makeDeleteProfilePhotoUseCase = makeUseCase
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

    var createBasicProfileUseCase: CreateBasicProfileUseCase {
        application.profileWebAPIUseCases.createBasicProfileUseCase
    }

    var fetchBasicProfileUseCase: FetchBasicProfileUseCase {
        application.profileWebAPIUseCases.fetchBasicProfileUseCase
    }

    var createBasicInfoUseCase: CreateBasicInfoUseCase {
        application.profileWebAPIUseCases.createBasicInfoUseCase
    }

    var fetchBasicInfoUseCase: FetchBasicInfoUseCase {
        application.profileWebAPIUseCases.fetchBasicInfoUseCase
    }

    var fetchProfileUseCase: FetchProfileUseCase {
        application.profileWebAPIUseCases.fetchProfileUseCase
    }

    var addProfilePhotoUseCase: AddProfilePhotoUseCase {
        application.profileWebAPIUseCases.addProfilePhotoUseCase
    }

    var fetchProfilePhotosUseCase: FetchProfilePhotosUseCase {
        application.profileWebAPIUseCases.fetchProfilePhotosUseCase
    }

    var fetchProfilePhotoUseCase: FetchProfilePhotoUseCase {
        application.profileWebAPIUseCases.fetchProfilePhotoUseCase
    }

    var changeProfilePhotoOrderUseCase: ChangeProfilePhotoOrderUseCase {
        application.profileWebAPIUseCases.changeProfilePhotoOrderUseCase
    }

    var deleteProfilePhotoUseCase: DeleteProfilePhotoUseCase {
        application.profileWebAPIUseCases.deleteProfilePhotoUseCase
    }

}
