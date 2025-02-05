//
//  GenderDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

package final class GenderDefaultRepository: GenderRepository {

    private let remoteDataSource: any GenderRemoteDataSource

    package init(remoteDataSource: some GenderRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    package func genders() async throws(FetchGendersError) -> [Gender] {
        try await remoteDataSource.genders()
    }

}
