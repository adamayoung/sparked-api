//
//  GenderSchema.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import GraphQLKit
import ReferenceDataApplication
import Vapor

final class GenderSchema<Resolver: ReferenceDataResolver>: PartialSchema<Resolver, Request> {

    @TypeDefinitions override var types: Types {
        Type(GenderDTO.self) {
            Field("id", at: \.id)
            Field("name", at: \.name)
            Field("code", at: \.code)
        }
    }

    @FieldDefinitions override var query: Fields {
        Field("genders", at: ReferenceDataResolver.fetchGenders) {
            Argument("id", at: \.id)
        }
    }

}
