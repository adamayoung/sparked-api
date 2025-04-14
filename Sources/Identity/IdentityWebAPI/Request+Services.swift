//
//  Request+Services.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/04/2025.
//

import Vapor

extension Request {

    var tokenPayloadService: any TokenPayloadService {
        application.identityServices.makeTokenPayloadService
    }

}
