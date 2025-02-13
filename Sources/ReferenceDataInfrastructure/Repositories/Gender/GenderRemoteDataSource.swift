//
//  GenderRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol GenderRemoteDataSource {

    func fetchAll() async throws(FetchGendersError) -> [Gender]

    func fetch(byID id: Gender.ID) async throws(FetchGenderError) -> Gender

}
