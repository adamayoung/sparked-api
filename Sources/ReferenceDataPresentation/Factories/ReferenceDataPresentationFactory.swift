//
//  ReferenceDataPresentationFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import Vapor

package final class ReferenceDataPresentationFactory: Sendable {

    private init() {}

    package static func makeCountryController() -> some RouteCollection {
        CountryController()
    }

    package static func makeGenderController() -> some RouteCollection {
        GenderController()
    }

}
