//
//  InterestGroupMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

struct InterestGroupMapper {

    private init() {}

    static func map(from model: InterestGroupModel) throws -> InterestGroup {
        try InterestGroup(
            id: model.requireID(),
            name: model.name
        )
    }

}
