//
//  BasicProfileRemoteDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

protocol BasicProfileRemoteDataSource {

    func create(_ basicProfile: BasicProfile) async throws(BasicProfileRepositoryError)

    func fetch(byID id: BasicProfile.ID) async throws(BasicProfileRepositoryError) -> BasicProfile

    func fetch(byUserID userID: User.ID) async throws(BasicProfileRepositoryError) -> BasicProfile

}
