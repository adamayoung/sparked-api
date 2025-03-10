//
//  BasicProfileSchema.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import GraphQLKit
import ProfileApplication
import Vapor

final class BasicProfileSchema<Resolver: ProfileResolver>: PartialSchema<Resolver, Request> {

    @TypeDefinitions override var types: Types {
        Type(BasicProfileDTO.self) {
            Field("id", at: \.id)
            Field("displayName", at: \.displayName)
            Field("age", at: \.age)
        }
    }

    @FieldDefinitions override var query: Fields {
        Field("basicProfile", at: Resolver.fetchBasicProfile) {
            Argument("id", at: \.id)
        }
    }

}
