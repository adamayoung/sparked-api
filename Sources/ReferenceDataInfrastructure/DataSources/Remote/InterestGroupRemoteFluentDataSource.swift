//
//  InterestGroupRemoteFluentDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class InterestGroupRemoteFluentDataSource: InterestGroupRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func fetchAll() async throws(InterestGroupRepositoryError) -> [InterestGroup] {
        let interestGroupModels: [InterestGroupModel]
        do {
            interestGroupModels = try await InterestGroupModel.query(on: database)
                .with(\.$interests)
                .all()
        } catch let error {
            throw .unknown(error)
        }

        let interestGroups: [InterestGroup]
        do {
            interestGroups = try interestGroupModels.map(InterestGroupMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return interestGroups
    }

    func fetch(byID id: InterestGroup.ID) async throws(InterestGroupRepositoryError)
        -> InterestGroup
    {
        let interestGroupModel: InterestGroupModel?
        do {
            interestGroupModel = try await InterestGroupModel.query(on: database)
                .with(\.$interests)
                .filter(\.$id == id)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let interestGroupModel else {
            throw .notFound
        }

        let interestGroup: InterestGroup
        do {
            interestGroup = try InterestGroupMapper.map(from: interestGroupModel)
        } catch let error {
            throw .unknown(error)
        }

        return interestGroup
    }

}
