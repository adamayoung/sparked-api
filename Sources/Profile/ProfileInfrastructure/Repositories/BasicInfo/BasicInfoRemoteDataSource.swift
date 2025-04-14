//
//  BasicInfoRemoteDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

protocol BasicInfoRemoteDataSource {

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError)

    func fetch(byID id: BasicInfo.ID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(byOwnerID ownerID: User.ID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(
        byProfileID profileID: BasicProfile.ID
    ) async throws(BasicInfoRepositoryError) -> BasicInfo

}
