//
//  RegisterUserInputMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication

struct RegisterUserInputMapper {

    private init() {}

    static func map(from requestModel: RegisterUserRequestModel) -> RegisterUserInput {
        RegisterUserInput(
            firstName: requestModel.firstName,
            familyName: requestModel.familyName,
            email: requestModel.email,
            password: requestModel.password
        )
    }

}
