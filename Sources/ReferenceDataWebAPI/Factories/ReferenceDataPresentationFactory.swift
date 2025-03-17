//
//  ReferenceDataWebAPIFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Vapor

package final class ReferenceDataWebAPIFactory: Sendable {

    private init() {}

    package static func makeCountryController() -> some RouteCollection {
        CountryController()
    }

    package static func makeGenderController() -> some RouteCollection {
        GenderController()
    }

    package static func makeInterestGroupController() -> some RouteCollection {
        InterestGroupController()
    }

    package static func makeInterestController() -> some RouteCollection {
        InterestController()
    }

}
