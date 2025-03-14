//
//  InterestRemoteFluentDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class InterestRemoteFluentDataSource: InterestRemoteDataSource {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func fetchAll(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest] {
        let interestModels: [InterestModel]
        do {
            interestModels = try await InterestModel.query(on: database)
                .with(\.$interestGroup)
                .filter(\.$interestGroup.$id == interestGroupID)
                .all()
        } catch let error {
            throw .unknown(error)
        }

        let interests: [Interest]
        do {
            interests = try interestModels.map(InterestMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return interests
    }

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest {
        let interestModel: InterestModel?
        do {
            interestModel = try await InterestModel.query(on: database)
                .with(\.$interestGroup)
                .filter(\.$id == id)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let interestModel else {
            throw .notFound
        }

        let interest: Interest
        do {
            interest = try InterestMapper.map(from: interestModel)
        } catch let error {
            throw .unknown(error)
        }

        return interest
    }

}
