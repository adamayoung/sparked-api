//
//  webAPIRoutes.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/03/2025.
//

import Vapor

func webAPIRoutes(_ routes: some RoutesBuilder) throws {
    try healthWebAPIRoutes(routes)
    try profileWebAPIRoutes(routes)
    try identityWebAPIRoutes(routes)
    try referenceDataWebAPIRoutes(routes)
}
