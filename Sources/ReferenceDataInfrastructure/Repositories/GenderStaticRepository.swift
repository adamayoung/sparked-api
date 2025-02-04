//
//  GenderStaticRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

package final class GenderStaticRepository: GenderRepository {

    package init() {}

    package func genders() async throws(FetchGendersError) -> [Gender] {
        Self.genders
    }

}

extension GenderStaticRepository {

    private static let genders: [Gender] = [
        Gender(
            id: UUID(uuidString: "EBE46F14-FA26-4577-A965-31293F2168C7") ?? UUID(),
            name: "Male"
        ),
        Gender(
            id: UUID(uuidString: "F2D4C883-4225-4B82-AB95-AD169D9160BB") ?? UUID(),
            name: "Female"
        ),
        Gender(
            id: UUID(uuidString: "2E1D25D0-E0FA-4A7F-99C8-962B43E25C33") ?? UUID(),
            name: "Other"
        )
    ]

}
