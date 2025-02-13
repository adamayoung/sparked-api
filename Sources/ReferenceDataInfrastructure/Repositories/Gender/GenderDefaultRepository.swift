//
//  GenderDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class GenderDefaultRepository: GenderRepository {

    private let remoteDataSource: any GenderRemoteDataSource

    init(remoteDataSource: some GenderRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchAll() async throws(FetchGendersError) -> [Gender] {
        try await remoteDataSource.fetchAll()
    }

    func fetch(byID id: Gender.ID) async throws(FetchGenderError) -> Gender {
        try await remoteDataSource.fetch(byID: id)
    }

}
