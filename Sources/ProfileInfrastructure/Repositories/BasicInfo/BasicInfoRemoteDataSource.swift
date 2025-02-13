//
//  BasicInfoRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

protocol BasicInfoRemoteDataSource {

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError)

    func fetch(byID id: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(byUserID userID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo

    func fetch(byProfileID profileID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo

}
