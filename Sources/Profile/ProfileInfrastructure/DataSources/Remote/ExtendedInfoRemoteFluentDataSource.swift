//
//  ExtendedInfoRemoteFluentDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Fluent
import Foundation
import ProfileApplication
import ProfileDomain

final class ExtendedInfoRemoteFluentDataSource: ExtendedInfoRemoteDataSource {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    func create(_ extendedInfo: ExtendedInfo) async throws(ExtendedInfoRepositoryError) {
        var existingExtendedInfo: ExtendedInfo?
        do {
            existingExtendedInfo = try await fetch(byProfileID: extendedInfo.profileID)
        } catch ExtendedInfoRepositoryError.notFound {
            existingExtendedInfo = nil
        } catch let error {
            throw error
        }

        guard existingExtendedInfo == nil else {
            throw .duplicate
        }

        let extendedInfoModel = ExtendedInfoModelMapper.map(from: extendedInfo)

        do {
            try await extendedInfoModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    func fetch(byID id: UUID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo {
        let extendedInfoModel: ExtendedInfoModel?
        do {
            extendedInfoModel = try await ExtendedInfoModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let extendedInfoModel else {
            throw .notFound
        }

        let extendedInfo: ExtendedInfo
        do {
            extendedInfo = try ExtendedInfoMapper.map(from: extendedInfoModel)
        } catch let error {
            throw .unknown(error)
        }

        return extendedInfo
    }

    func fetch(byOwnerID ownerID: UUID) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo {
        let extendedInfoModel: ExtendedInfoModel?
        do {
            extendedInfoModel = try await ExtendedInfoModel.query(on: database)
                .filter(\.$ownerID == ownerID)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let extendedInfoModel else {
            throw .notFound
        }

        let extendedInfo: ExtendedInfo
        do {
            extendedInfo = try ExtendedInfoMapper.map(from: extendedInfoModel)
        } catch let error {
            throw .unknown(error)
        }

        return extendedInfo
    }

    func fetch(
        byProfileID profileID: UUID
    ) async throws(ExtendedInfoRepositoryError) -> ExtendedInfo {
        let extendedInfoModel: ExtendedInfoModel?
        do {
            extendedInfoModel = try await ExtendedInfoModel.query(on: database)
                .filter(\.$profileID == profileID)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let extendedInfoModel else {
            throw .notFound
        }

        let extendedInfo: ExtendedInfo
        do {
            extendedInfo = try ExtendedInfoMapper.map(from: extendedInfoModel)
        } catch let error {
            throw .unknown(error)
        }

        return extendedInfo
    }

}
