//
//  referenceDataRoutes.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataWebAPI
import Vapor

func referenceDataWebAPIRoutes(_ routes: RoutesBuilder) throws {
    let referenceDataRouter = routes.grouped("reference-data")

    try referenceDataRouter.register(collection: ReferenceDataWebAPIFactory.makeCountryController())

    try referenceDataRouter.register(collection: ReferenceDataWebAPIFactory.makeGenderController())

    try referenceDataRouter.register(
        collection: ReferenceDataWebAPIFactory.makeInterestGroupController()
    )

    try referenceDataRouter.register(
        collection: ReferenceDataWebAPIFactory.makeInterestController()
    )

    try referenceDataRouter.register(
        collection: ReferenceDataWebAPIFactory.makeStarSignController()
    )

    try referenceDataRouter.register(
        collection: ReferenceDataWebAPIFactory.makeEducationLevelController()
    )
}
