//
//  BasicInfoStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class BasicInfoStubRepository: BasicInfoRepository {

    var createResult: Result<Void, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateBasicInfo: BasicInfo?

    var fetchByIDResult: Result<BasicInfo, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: UUID?

    var fetchByUserIDResult: Result<BasicInfo, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var fetchByUserIDWasCalled = false
    private(set) var lastFetchByUserIDUserID: UUID?

    var fetchByProfileIDResult: Result<BasicInfo, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var fetchByProfileIDWasCalled = false
    private(set) var lastFetchByProfileIDProfileID: UUID?

    init() {}

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError) {
        createWasCalled = true
        lastCreateBasicInfo = basicInfo

        return try createResult.get()
    }

    func fetch(byID id: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

    func fetch(byUserID userID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        fetchByUserIDWasCalled = true
        lastFetchByUserIDUserID = userID

        return try fetchByUserIDResult.get()
    }

    func fetch(byProfileID profileID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        fetchByProfileIDWasCalled = true
        lastFetchByProfileIDProfileID = profileID

        return try fetchByProfileIDResult.get()
    }

}
