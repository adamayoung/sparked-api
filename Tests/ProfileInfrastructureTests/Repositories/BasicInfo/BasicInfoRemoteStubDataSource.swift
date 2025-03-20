//
//  BasicInfoRemoteStubDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

@testable import ProfileInfrastructure

final class BasicInfoRemoteStubDataSource: BasicInfoRemoteDataSource {

    var createResult: Result<Void, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateBasicInfo: BasicInfo?

    var fetchByIDResult: Result<BasicInfo, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: UUID?

    var fetchByOwnerIDResult: Result<BasicInfo, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var fetchByOwnerIDWasCalled = false
    private(set) var lastFetchByOwnerIDOwnerID: UUID?

    var fetchByProfileIDResult: Result<BasicInfo, BasicInfoRepositoryError> = .failure(.unknown())
    private(set) var fetchByProfileIDWasCalled = false
    private(set) var lastFetchByProfileIDProfileID: UUID?

    init() {}

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError) {
        createWasCalled = true
        lastCreateBasicInfo = basicInfo

        try createResult.get()
    }

    func fetch(byID id: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

    func fetch(byOwnerID ownerID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        fetchByOwnerIDWasCalled = true
        lastFetchByOwnerIDOwnerID = ownerID

        return try fetchByOwnerIDResult.get()
    }

    func fetch(byProfileID profileID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        fetchByProfileIDWasCalled = true
        lastFetchByProfileIDProfileID = profileID

        return try fetchByProfileIDResult.get()
    }

}
