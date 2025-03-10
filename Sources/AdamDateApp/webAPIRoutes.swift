//
//  webAPIRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Vapor

func webAPIRoutes(_ routes: RoutesBuilder) throws {
    try profileWebAPIRoutes(routes)
    try identityWebAPIRoutes(routes)
    try referenceDataWebAPIRoutes(routes)
}
