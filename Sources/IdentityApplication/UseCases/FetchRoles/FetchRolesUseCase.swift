//
//  FetchRolesUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation

package protocol FetchRolesUseCase {

    func execute() async throws(FetchRolesError) -> [RoleDTO]

}
