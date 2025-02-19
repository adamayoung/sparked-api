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

    package static func makeProfileController() -> some RouteCollection {
        ProfileController()
    }

    package static func makeBasicProfileController() -> some RouteCollection {
        BasicProfileController()
    }

    package static func makeBasicInfoController() -> some RouteCollection {
        BasicInfoController()
    }

}
