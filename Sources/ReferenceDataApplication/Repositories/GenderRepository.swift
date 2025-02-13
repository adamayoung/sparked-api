//
//  FetchGendersRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

package protocol GenderRepository {

    func fetchAll() async throws(FetchGendersError) -> [Gender]

    func fetch(byID id: Gender.ID) async throws(FetchGenderError) -> Gender

}
