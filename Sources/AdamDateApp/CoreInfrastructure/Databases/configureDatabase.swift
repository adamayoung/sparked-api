//
//  configureDatabase.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Vapor

func configureDatabase(on app: Application) throws {
    try configureIdentityDatabase(on: app)
    try configureProfileDatabase(on: app)
    try configureReferenceDataDatabase(on: app)
}
