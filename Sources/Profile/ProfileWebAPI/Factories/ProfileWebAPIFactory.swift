//
//  ProfileWebAPIFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/02/2025.
//

import Vapor

package final class ProfileWebAPIFactory: Sendable {

    private init() {}

    package static func makeProfileController() -> some RouteCollection {
        ProfileController()
    }

    package static func makeBasicProfileController() -> some RouteCollection {
        BasicProfileController()
    }

    package static func makeBasicInfoController() -> some RouteCollection {
        BasicInfoController()
    }

    package static func makeExtendedInfoController() -> some RouteCollection {
        ExtendedInfoController()
    }

    package static func makePhotoController() -> some RouteCollection {
        PhotoController()
    }

    package static func makeInterestController() -> some RouteCollection {
        InterestController()
    }

}
