//
//  GenderRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

package protocol GenderRemoteDataSource {

    func genders() async throws(FetchGendersError) -> [Gender]

}
