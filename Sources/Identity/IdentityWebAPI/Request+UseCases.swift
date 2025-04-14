//
//  Request+UseCases.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/04/2025.
//

import IdentityApplication
import Vapor

extension Request {

    var fetchUserUseCase: any FetchUserUseCase {
        application.identityUseCases.fetchUserUseCase
    }

    var registerUserUseCase: any RegisterUserUseCase {
        application.identityUseCases.registerUserUseCase
    }

    var authenticateUserUseCase: any AuthenticateUserUseCase {
        application.identityUseCases.authenticateUserUseCase
    }

}
