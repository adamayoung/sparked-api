//
//  Request+UseCases.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/04/2025.
//

import ProfileApplication
import Vapor

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
