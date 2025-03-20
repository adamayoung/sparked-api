//
//  EducationLevelMigrationV2.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Fluent
import Foundation

struct EducationLevelMigrationV2: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.transaction { database in
            for educationLevel in Self.educationLevels {
                try await educationLevel.save(on: database)
            }
        }
    }

    func revert(on database: Database) async throws {
        try await database.transaction { database in
            for educationLevel in Self.educationLevels {
                try await EducationLevelModel
                    .find(educationLevel.requireID(), on: database)?
                    .delete(force: true, on: database)
            }
        }
    }

}

extension EducationLevelMigrationV2 {

    static let educationLevels = [
        EducationLevelModel(
            id: UUID(uuidString: "1431C041-6461-4AA6-9C2D-6A851504636A"),
            name: "Sixth form",
            nameKey: "REFERENCE_DATA.EDUCATION_LEVEL.SIXTH_FORM",
            index: 0
        ),
        EducationLevelModel(
            id: UUID(uuidString: "08794A68-A2CA-4AEC-950E-A6AC19A95470"),
            name: "Technical college",
            nameKey: "REFERENCE_DATA.EDUCATION_LEVEL.TECHNICAL_COLLEGE",
            index: 1
        ),
        EducationLevelModel(
            id: UUID(uuidString: "8699A0E6-71C4-401C-B1B6-9938D1D6ECFB"),
            name: "Studying my undergrad",
            nameKey: "REFERENCE_DATA.EDUCATION_LEVEL.STUDYING_MY_UNDERGRAD",
            index: 2
        ),
        EducationLevelModel(
            id: UUID(uuidString: "370072E8-A08C-40AB-9FA5-3A11846A3C91"),
            name: "Undergraduate degree",
            nameKey: "REFERENCE_DATA.EDUCATION_LEVEL.UNDERGRADUATE_DEGREE",
            index: 3
        ),
        EducationLevelModel(
            id: UUID(uuidString: "71E27074-9974-4F19-A05B-7126E2180920"),
            name: "Studying my postgrad",
            nameKey: "REFERENCE_DATA.EDUCATION_LEVEL.STUDYING_MY_POSTGRAD",
            index: 4
        ),
        EducationLevelModel(
            id: UUID(uuidString: "DB6DEB98-3125-4315-BC0E-02B8E3053E50"),
            name: "Postgraduate degree",
            nameKey: "REFERENCE_DATA.EDUCATION_LEVEL.POSTGRADUATE_DEGREE",
            index: 5
        )
    ]

}
