//
//  FetchGendersUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol FetchGendersUseCase: Sendable {

    func execute() async throws(FetchGendersError) -> [GenderDTO]

}
