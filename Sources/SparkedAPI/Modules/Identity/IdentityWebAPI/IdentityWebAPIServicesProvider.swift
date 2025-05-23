//
//  IdentityServicesProvider.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/02/2025.
//

import AuthKit
import Foundation
import IdentityWebAPI
import Vapor

extension Application.IdentityServices.Provider {

    static var `default`: Self {
        Self { app in
            app.identityServices.use { app in
                IdentityAdapterFactory.makeTokenPayloadService(
                    jwtConfiguration: app.jwtConfiguration
                )
            }
        }
    }

}
