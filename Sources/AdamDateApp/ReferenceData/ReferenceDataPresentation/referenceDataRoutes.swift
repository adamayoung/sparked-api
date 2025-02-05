//
//  referenceDataRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataPresentation
import Vapor

func referenceDataRoutes(_ routes: RoutesBuilder, container: Container) throws {
    let referenceDataRouter = routes.grouped("reference-data")
    try referenceDataRouter.register(collection: container.resolve(CountryController.self))
    try referenceDataRouter.register(collection: container.resolve(GenderController.self))
}
