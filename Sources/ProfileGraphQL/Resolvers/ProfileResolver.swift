//
//  ProfileResolver.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import ProfileApplication
import Vapor

package protocol ProfileResolver: Sendable {

    func fetchBasicProfile(
        req: Request,
        args: FetchBasicProfileArguments
    ) async throws -> BasicProfileDTO

}

package struct FetchBasicProfileArguments: Codable {
    package let id: UUID?
}
