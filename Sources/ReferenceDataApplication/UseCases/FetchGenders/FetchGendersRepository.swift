//
//  FetchGendersRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

package protocol FetchGendersRepository {

    func genders() async throws(FetchGendersError) -> [Gender]

}
