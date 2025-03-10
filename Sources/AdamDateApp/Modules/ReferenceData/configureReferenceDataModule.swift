//
//  configureReferenceDataModule.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import ReferenceDataGraphQL
import ReferenceDataWebAPI
import Vapor

func configureReferenceDataModule(on app: Application) {
    app.referenceDataWebAPIUseCases.use(.default)
    app.referenceDataGraphQLUseCases.use(.default)
}
