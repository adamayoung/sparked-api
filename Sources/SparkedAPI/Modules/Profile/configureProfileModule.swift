//
//  configureProfileModule.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/03/2025.
//

import ProfileWebAPI
import Vapor

func configureProfileModule(on app: Application) {
    app.profileWebAPIUseCases.use(.default)
}
