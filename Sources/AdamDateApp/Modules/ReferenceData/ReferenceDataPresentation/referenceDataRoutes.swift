//
//  referenceDataRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataPresentation
import Vapor

func referenceDataRoutes(_ routes: RoutesBuilder) throws {
    let referenceDataRouter = routes.grouped("reference-data")

    try referenceDataRouter.register(
        collection: ReferenceDataPresentationFactory.makeCountryController()
    )

    try referenceDataRouter.register(
        collection: ReferenceDataPresentationFactory.makeGenderController()
    )
}
