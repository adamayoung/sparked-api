//
//  FetchGenderUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package protocol FetchGenderUseCase {

    func execute(id: GenderDTO.ID) async throws(FetchGenderError) -> GenderDTO

}
