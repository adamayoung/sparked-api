//
//  BasicInfoRemoteFluentDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Fluent
import Foundation
import ProfileApplication
import ProfileDomain

final class BasicInfoRemoteFluentDataSource: BasicInfoRemoteDataSource {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    func create(_ basicInfo: BasicInfo) async throws(BasicInfoRepositoryError) {
        var existingBasicInfo: BasicInfo?
        do {
            existingBasicInfo = try await fetch(byProfileID: basicInfo.profileID)
        } catch BasicInfoRepositoryError.notFound {
            existingBasicInfo = nil
        } catch let error {
            throw error
        }

        guard existingBasicInfo == nil else {
            throw .duplicate
        }

        let basicInfoModel = BasicInfoModelMapper.map(from: basicInfo)

        do {
            try await basicInfoModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    func fetch(byID id: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfoModel: BasicInfoModel?
        do {
            basicInfoModel = try await BasicInfoModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let basicInfoModel else {
            throw .notFound
        }

        let basicInfo: BasicInfo
        do {
            basicInfo = try BasicInfoMapper.map(from: basicInfoModel)
        } catch let error {
            throw .unknown(error)
        }

        return basicInfo
    }

    func fetch(byOwnerID ownerID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfoModel: BasicInfoModel?
        do {
            basicInfoModel = try await BasicInfoModel.query(on: database)
                .filter(\.$ownerID == ownerID)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let basicInfoModel else {
            throw .notFound
        }

        let basicInfo: BasicInfo
        do {
            basicInfo = try BasicInfoMapper.map(from: basicInfoModel)
        } catch let error {
            throw .unknown(error)
        }

        return basicInfo
    }

    func fetch(byProfileID profileID: UUID) async throws(BasicInfoRepositoryError) -> BasicInfo {
        let basicInfoModel: BasicInfoModel?
        do {
            basicInfoModel = try await BasicInfoModel.query(on: database)
                .filter(\.$profileID == profileID)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let basicInfoModel else {
            throw .notFound
        }

        let basicInfo: BasicInfo
        do {
            basicInfo = try BasicInfoMapper.map(from: basicInfoModel)
        } catch let error {
            throw .unknown(error)
        }

        return basicInfo
    }

}
