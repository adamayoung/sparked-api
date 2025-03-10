//
//  CountrySchema.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import GraphQLKit
import ReferenceDataApplication
import Vapor

final class CountrySchema<Resolver: ReferenceDataResolver>: PartialSchema<Resolver, Request> {

    @TypeDefinitions override var types: Types {
        Type(CountryDTO.self) {
            Field("id", at: \.id)
            Field("name", at: \.name)
            Field("code", at: \.code)
        }
    }

    @FieldDefinitions override var query: Fields {
        Field("countries", at: Resolver.fetchCountries) {
            Argument("id", at: \.id)
        }
    }

}
